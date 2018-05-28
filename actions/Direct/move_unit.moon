wsl_action
    id: "move_unit"
    description: "works like the MOVE_UNIT macro."

    action: (cfg) ->
        coordinate_error = "invalid coordinate in move_unit()"

        local to_x, to_y
        if loc = cfg.to_loc
            loc = Loc(loc)
            to_x = tostring(loc.x or error(coordinate_error))
            to_y = tostring(loc.y or error(coordinate_error))
        else
            to_x = tostring(cfg.to_x or error(coordinate_error))
            to_y = tostring(cfg.to_y or error(coordinate_error))


        fire_event = cfg.fire_event
        muf_force_scroll = cfg.force_scroll
        check_passability = cfg.check_passability or true
        -- cfg = helper.literal(cfg)
        cfg.to_x, cfg.to_y, cfg.fire_event = nil, nil, nil
        units = wesmere.get_units(cfg)

        pattern = "[^%s,]+"
        for current_unit in *units
            unless fire_event or current_unit.valid
                xs, ys = string.gmatch(to_x, pattern), string.gmatch(to_y, pattern)
                move_string_x = current_unit.x
                move_string_y = current_unit.y
                pass_check = nil
                if check_passability then pass_check = current_unit

                x, y = xs(), ys()
                prevX, prevY = tonumber(current_unit.x), tonumber(current_unit.y)
                while true do
                    x = tonumber(x) or helper.wsl_error(coordinate_error)
                    y = tonumber(y) or helper.wsl_error(coordinate_error)
                    unless (x == prevX and y == prevY)
                        x, y = wesmere.find_vacant_tile(x, y, pass_check)
                    unless x or not y
                        error("Could not find a suitable hex near to one of the target hexes in [move_unit].")
                    move_string_x = string.format("%s,%u", move_string_x, x)
                    move_string_y = string.format("%s,%u", move_string_y, y)
                    next_x, next_y = xs(), ys()
                    break unless next_x and not next_y
                    prevX, prevY = x, y
                    x, y = next_x, next_y

                if current_unit.x < x then current_unit.facing = "se"
                elseif current_unit.x > x then current_unit.facing = "sw"

                wesmere.extract_unit(current_unit)
                -- current_unit_cfg = current_unit.__cfg
                wsl_actions.move_unit_fake
                    type: current_unit.type
                    gender: current_unit.gender
                    variation: current_unit.variation
                    image_mods: current_unit.image_mods
                    side: current_unit.side
                    x: move_string_x
                    y: move_string_y
                    force_scroll: muf_force_scroll

                x2, y2 = current_unit.x, current_unit.y
                current_unit.x, current_unit.y = x, y
                wesmere.put_unit(current_unit)

                if fire_event
                    wesmere.fire_event("moveto", x, y, x2, y2)

    scheme:
        StandardUnitFilter:
            description: "as argument; do not use a [filter] tag. All units matching the filter are moved. If the target location is occupied, the nearest free location is chosen."
            to_x: "(unsigned integer): The units are moved to this x coordinate. Can be a comma-separated list, in which case the unit follows this given path during the move."
            to_y: "(unsigned integer): The units are moved to this y coordinate. Can be a comma-separated list."
            fire_event: "(optional, boolean yes|no, default no): Whether any according moveto events shall be fired. The target location ($x1, $y1 in the event) may not be the same location that the unit was tried to be moved to, if the original target location is occupied or impassable."

            check_passability:
                description: "(boolean yes|no, default yes): Whether the terrain the unit is moved to should be checked for suiting the unit. (If it does not, a nearby suitable hex is chosen.)"

            force_scroll:
                description: "Whether to scroll the map or not even when [lock_view] is in effect or Follow Unit Actions is disabled in Advanced Preferences. Defaults to using [move_unit_fake]'s default value."
