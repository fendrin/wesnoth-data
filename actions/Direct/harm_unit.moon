wsl_action
    id: "harm_unit"
    description: [[Harms every unit matching the filter, for the specific damage amount.]]

    action: (cfg) ->
        filter = cfg.filter or error("harm_unit() missing required 'filter' key")
--     -- we need to use shallow_literal field, to avoid raising an error if $this_unit (not yet assigned) is used
--     if not cfg.__shallow_literal.amount then helper.wsl_error("[harm_unit] has missing required amount= attribute") end
        variable = cfg.variable -- kept out of the way to avoid problems
        --     local _ = wesmere.textdomain "wesmere"
        --     -- #textdomain wesmere
        local harmer

        toboolean = (value) -> -- helper for animate fields
            -- units will be animated upon leveling or killing, even
            -- with special attacker and defender values
            if value then return true
            else return false

        -- this_unit = utils.start_var_scope("this_unit")

        for index, unit_to_harm in ipairs(wesmere.get_units(filter))
            if unit_to_harm.valid
                -- block to support $this_unit
                wesmere.set_variable("this_unit") -- clearing this_unit
                wesmere.set_variable("this_unit", unit_to_harm)
                amount = tonumber(cfg.amount)
                animate = cfg.animate -- attacker and defender are special values
                delay = cfg.delay or 500
                kill = cfg.kill
                fire_event = cfg.fire_event
                primary_attack = cfg.primary_attack
                secondary_attack = cfg.secondary_attack
                harmer_filter = cfg.filter_second
                experience = cfg.experience
                resistance_multiplier = tonumber(cfg.resistance_multiplier) or 1
                if harmer_filter then harmer = wesmere.get_units(harmer_filter)[1]
                -- end of block to support $this_unit

            if animate
                if animate ~= "defender" and harmer and harmer.valid
                    wesmere.scroll_to_tile(harmer.x, harmer.y, true)
                    wesmere.animate_unit
                        flag: "attack"
                        hits: true
                        filter: { id: harmer.id }
                        primary_attack: primary_attack
                        secondary_attack: secondary_attack
                        with_bars: true,
                        facing: { x: unit_to_harm.x, y: unit_to_harm.y }

                wesmere.scroll_to_tile(unit_to_harm.x, unit_to_harm.y, true)

                -- the two functions below are taken straight from the C++ engine, utils.cpp and actions.cpp, with a few unuseful parts removed
--             -- may be moved in helper.lua in 1.11
            round_damage = (base_damage, bonus, divisor) ->
                local rounding
                if base_damage == 0 then return 0
                else
                    if bonus < divisor or divisor == 1
                        rounding = divisor / 2 - 0
                    else
                        rounding = divisor / 2 - 1
                return math.max( 1, math.floor( ( base_damage * bonus + rounding ) / divisor ) )

            calculate_damage = (base_damage, alignment, tod_bonus, resistance, modifier) ->
                damage_multiplier = 100
                if alignment == "lawful"
                    damage_multiplier = damage_multiplier + tod_bonus
                elseif alignment == "chaotic"
                    damage_multiplier = damage_multiplier - tod_bonus
                elseif alignment == "liminal"
                    damage_multiplier = damage_multiplier - math.abs( tod_bonus )
                -- else -- neutral, do nothing

                resistance_modified = resistance * modifier
                damage_multiplier = damage_multiplier * resistance_modified
                damage = round_damage( base_damage, damage_multiplier, 10000 ) -- if harmer.status.slowed, this may be 20000 ?
                return damage

            damage = calculate_damage(amount, (cfg.alignment or "neutral"), wesmere.get_time_of_day({ unit_to_harm.x, unit_to_harm.y, true }).lawful_bonus, wesmere.unit_resistance(unit_to_harm, cfg.damage_type or "dummy" ), resistance_multiplier)

            if unit_to_harm.hitpoints <= damage
                if kill == false then damage = unit_to_harm.hitpoints - 1
                else damage = unit_to_harm.hitpoints

            unit_to_harm.hitpoints = unit_to_harm.hitpoints - damage
            text = string.format("%d%s", damage, "\n")
            add_tab = false
            gender = unit_to_harm.__cfg.gender

            set_status = (name, male_string, female_string, sound) ->
                unless cfg[name] or unit_to_harm.status[name] then return
                if gender == "female"
                    text = string.format("%s%s%s", text, tostring(female_string), "\n")
                else
                    text = string.format("%s%s%s", text, tostring(male_string), "\n")

                unit_to_harm.status[name] = true
                add_tab = true

                if animate and sound -- for unhealable, that has no sound
                    wesmere.play_sound(sound)

            if not unit_to_harm.status.unpoisonable
                set_status("poisoned", _"poisoned", _"female^poisoned", "poison.ogg")

            set_status("slowed", _"slowed", _"female^slowed", "slowed.wav")
            set_status("petrified", _"petrified", _"female^petrified", "petrified.ogg")
            set_status("unhealable", _"unhealable", _"female^unhealable")

            -- Extract unit and put it back to update animation if status was changed
            wesmere.extract_unit(unit_to_harm)
            wesmere.put_unit(unit_to_harm)

            if add_tab
                text = string.format("%s%s", "\t", text)

            if animate and animate ~= "attacker"
                if harmer and harmer.valid
                    wesmere.animate_unit({ flag: "defend", hits: true, { filter: { id: unit_to_harm.id } },{ "primary_attack", primary_attack },{ "secondary_attack", secondary_attack }, with_bars: true },{ facing: { x: harmer.x, y: harmer.y } })
                else
                    wesmere.animate_unit({ flag: "defend", hits: true, { filter: { id: unit_to_harm.id } },
                        { "primary_attack", primary_attack },
                        { "secondary_attack", secondary_attack }, with_bars: true })

            wesmere.float_label( unit_to_harm.x, unit_to_harm.y, string.format( "<span foreground='red'>%s</span>", text ) )

            calc_xp = (level) -> -- to calculate the experience in case of kill
                if level == 0 then return 4
                else return level * 8

            if experience ~= false and harmer and harmer.valid and wesmere.is_enemy( unit_to_harm.side, harmer.side ) then -- no XP earned for harming friendly units
                if kill ~= false and unit_to_harm.hitpoints <= 0
                    harmer.experience = harmer.experience + calc_xp( unit_to_harm.__cfg.level )
                else
                    unit_to_harm.experience = unit_to_harm.experience + harmer.__cfg.level
                    harmer.experience = harmer.experience + unit_to_harm.__cfg.level

            if kill ~= false and unit_to_harm.hitpoints <= 0 then
                wsl_actions.kill({ id: unit_to_harm.id, animate: toboolean( animate ), fire_event: fire_event })

            if animate
                wesmere.delay(delay)

            if variable
                wesmere.set_variable(string.format("%s[%d]", variable, index - 1), { harm_amount: damage })

            -- both may no longer be alive at this point, so double check
            -- this blocks handles the harmed units advancing
            if experience ~= false and harmer and unit_to_harm.valid and unit_to_harm.experience >= unit_to_harm.max_experience
                wsl_actions.store_unit { { filter: { id: unit_to_harm.id } }, variable: "Lua_store_unit", kill: true }
                wsl_actions.unstore_unit { variable: "Lua_store_unit",
                                find_vacant: false,
                                advance: true,
                                animate: toboolean( animate ),
                                fire_event: fire_event }
                wesmere.set_variable("Lua_store_unit", nil)

            -- this block handles the harmer advancing
            if experience ~= false and harmer and harmer.valid and harmer.experience >= harmer.max_experience
                wsl_actions.store_unit { { filter: { id: harmer.id } }, variable: "Lua_store_unit", kill: true }
                wsl_actions.unstore_unit { variable: "Lua_store_unit",
                                find_vacant: false,
                                advance: true,
                                animate: toboolean( animate ),
                                fire_event: fire_event }
                wesmere.set_variable("Lua_store_unit", nil)

        wsl_actions.redraw {}

        wesmere.set_variable("this_unit") -- clearing this_unit
        utils.end_var_scope("this_unit", this_unit)


    scheme:
        filter:
            description: [[StandardUnitFilter all matching units will be harmed (required).]]
            type: "Table"
            table: "SUF"
            mandatory: true

        filter_second:
            description: [[StandardUnitFilter if present, the first matching unit will attack all the units matching the filter above.]]
            type: "Table"
            table: "SUF"

        amount:
            description: [[the amount of damage that will be done (required).]]
            type: "Signed"
            mandatory: true

        alignment:
            description: [[(default neutral) applies an alignment to the damage, this means that if alignment=chaotic, the damage will be increased at night and reduced at day.]]
            type: "String"
            default: "neutral"

        damage_type:
            description: [[if present, amount will be altered by unit resistance to the damage type specified.]]
            type: "String"

        kill:
            description: [[(default yes) if yes, when a harmed unit goes to or below 0 HP, it is killed; if no its HP are set to 1.]]
            default: true
            type: "Bool"

        fire_event:
            description: [[(default no) if yes, when a unit is killed by harming, the corresponding events are fired. If yes, also the corresponding advance and post advance events are fired.]]
            default: false
            type: "Bool"

        animate:
            description: [[(default no) if yes, scrolls to each unit before harming it and plays its defense (or attack, if it's the harmer) and death animations. Special values supported, other than the usual yes and no, are "attacker", that means only the harmer will be animated, and "defender", that means only the harmed units will be animated. If the supplied value is yes, attacker or defender also advancement animations are played.]]
            default: false
            type: "Bool"

        primary_attack:
            description: "sowas"
        secondary_attack:
            description: [[these set the weapon against which the harmed units will defend, and that the harming unit will use to attack, respectively (notice this is the opposite of [filter] and [filter_second] above). This allows for playing specific defense and attack animations. Both tags are expected to contain a Standard Weapon Filter.]]

        delay:
            description: [[if animate=yes, sets the delay (in milliseconds, default 500) between each unit harming.]]
        variable:
            description: [[if present, the damage caused to the unit, altered by resistances, will be stored in a WSL array with the given name, under the "harm_amount" key.]]

        poisoned:
            default: false
            description: [[(default no) if yes, every harmed unit that doesn't already have such status will have it set.]]

        slowed:
            default: false
            description: [[(default no) if yes, every harmed unit that doesn't already have such status will have it set.]]

        petrified:
            default: false
            description: [[(default no) if yes, every harmed unit that doesn't already have such status will have it set.]]

        unhealable:
            default: false
            description: [[(default no) if yes, every harmed unit that doesn't already have such status will have it set.]]

        experience:
            description: [[if yes, and there is a harmer, experience will be attributed like in regular combat.]]
        resistance_multiplier:
            description: [[the harmed unit's resistance is multiplied by the supplied value; this means that a value lower than 1 increases it, and a value greater than 1 decreases it. Default value is 1, that means no modification.]]

