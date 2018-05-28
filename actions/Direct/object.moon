
wsl_action
    id: "object"
    description: "Gives some unit an object which modifies their stats in some way."

    action: (cfg) ->


        check_key = (val, key, tag, convert_spaces) ->
            unless val then return nil
            if convert_spaces
                val = tostring(val)\gsub(' ', '_')
            unless val\match('^[a-zA-Z0-9_]+$')
                wesmere.wml_error("Invalid " .. key .. "= in [" .. tag .. "]")
            return val


        -- helper = wesmere.require "lua/helper.lua"
        -- utils = wesmere.require "lua/wsl-utils.lua"
        -- T = helper.set_wsl_tag_metatable {}
        wsl_actions = wesmere.wsl_actions

        used_items = {}

        -----

        context = wesmere.current.event_context

        -- If this item has already been used
        obj_id = check_key(cfg.id, "id", "object", true)
        if obj_id and used_items[obj_id] then return

        local unit, command_type, text

        if filter = cfg.filter
            unit = wesmere.get_units(filter)[1]
        else
            unit = wesmere.get_unit(context.x1, context.y1)

        -- If a unit matches the filter, proceed
        if unit
            text = tostring(cfg.description or "")
            command_type = "then"

            dvs = cfg.delayed_variable_substitution
            add = cfg.no_write ~= true
            -- if dvs
            --     wesmere.add_modification(unit, "object", helper.literal(cfg), add)
            -- else
            --     wesmere.add_modification(unit, "object", helper.parsed(cfg), add)

            wesmere.select_hex(unit.x, unit.y, false)

            -- Mark this item as used up
            if obj_id then used_items[obj_id] = true
        else
            text = tostring(cfg.cannot_use_message or "")
            command_type = "else"

        -- Default to silent if object has no description
        silent = cfg.silent
        if silent == nil then silent = (text\len! == 0)

        unless silent
            wsl_actions.redraw{}
            name = tostring(cfg.name or "")
            wesmere.show_popup_dialog(name, text, cfg.image)

        if command_type = cfg.command_type
            for cmd in *command_type
                action = utils.handle_event_commands(cmd, "conditional")
                break if action ~= "none"

        -- old_on_load = wesmere.game_events.on_load
        -- function wesmere.game_events.on_load(cfg)
        --     for i = 1,#cfg do
        --         if cfg[i][1] == "used_items" then
        --             -- Not quite sure if this will work
        --             -- Might need to loop through and copy each ID separately
        --             used_items = cfg[i][2]
        --             table.remove(cfg, i)
        --             break
        --         end
        --     end
        --     old_on_load(cfg)
        -- end

        -- local old_on_save = wesmere.game_events.on_save
        -- function wesmere.game_events.on_save()
        --     local cfg = old_on_save()
        --     table.insert(cfg, T.used_items(used_items) )
        --     return cfg
        -- end

        -- function wesmere.wsl_conditionals.found_item(cfg)
        --     return used_items[utils.check_key(cfg.id, "id", "found_item", true)]
        -- end





    scheme:
        id:
            description: [[(Optional) when the object is picked up, a flag is set for id. The object cannot be picked up if a flag for id has been set. This means that any object with an id can only be used once, even if first_time_only:false is set for the event. This restriction is per level. In a campaign objects with the same id can be assigned once per level. For filtering objects, custom key can be used, such as item_id.]]
            type: "string"
            mandatory: false
        delayed_variable_substitution:
            description: [[If set to "true", the wsl table contained in this object is not variable-substituted at execution time of the event where this object is within. You need this to work around a bug when adding ABILITY_TELEPORT via an [object] or when using [object][effect][filter]with a $this_unit (see http://gna.org/bugs/index.php?18893).]]
            type: "bool"
            default: false
        effect:
            description: [[one or more effect elements may be listed. See EffectWSL for a description of [effect].]]
        duration:
            description: [[if 'scenario', effects only last until the end of the level (note : 'level' is the scenario, so this doesn't mean it last until the unit levels-up).
        -- if 'forever' or not set, effects never wear off.
        -- if 'turn', effects only last until the start of the unit's next turn (when the unit refreshes movement and attacks). (Like other start-of-turn behavior, objects with a duration of "turn" won't expire before turn 2.)
        -- (Version 1.13.1 and later only) if 'turn end' or 'turn_end', effects only last until the end of the unit's next turn (exactly like the slowed status).]]
        filter:
            description: [[with a StandardUnitFilter as argument. The first unit found that matches the filter will be given the object. Only on-map units are considered. If no unit matches or no [filter] is supplied, it is tried to apply the object to the unit at the $x1,$y1 location of the event where this [object] is in. The case of no unit being at that spot is handled in the same way as no unit matching a given filter ([else] commands executed, cannot_use_message displayed)]]
        then:
            description: [[a subtag that lets you execute actions if the filter conditions are met. The most common action that should be inside here is a [remove_item] tag, but you could probably put any tags that otherwise work in a [then] tag.]]
        else:
            description: [[a subtag that lets you execute actions if the filter conditions are *not* met.]]
        silent:
            description: [[whether or not messages should be suppressed. Default is "no". (Version 1.13.2 and later only) If no description is provided, this defaults to true, but can still be overridden.]]
            type: "Bool"
            default: false
        image:
            description: [[the displayed image of the object.]]
            type: "tString"
        name:
            description:[[(translatable) displayed as a caption of the image.]]
            type: "tString"
        description:
            description: [[(translatable) displayed as a message of the image.]]
            type: "tString"
        cannot_use_message:
            description: [[(translatable) displayed instead of description if no unit passes the filter test.]]
            type: "tString"
        no_write:
            description: [[(Version 1.13.1 and later only) (bool, default false). If true, the contents of [effect] will be applied to the relevant unit, but the [object] tag will not be written to unit.modifications. This renders duration= irrelevant.]]
            type: "Bool"
            default: false
