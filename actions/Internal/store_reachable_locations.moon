wsl_action
    id: "store_reachable_locations"
    description: "Stores locations reachable by the given units. Can store either the movement, attack or vision ranges."

    action: (cfg, wesmere) ->

        unit_filter = cfg.filter
        --    helper.wsl_error "[store_reachable_locations] missing required [filter] tag"
        location_filter = cfg.filter_location
        range = cfg.range or "movement"
        moves = cfg.moves or "current"
        variable = cfg.variable
        --or helper.wsl_error "[store_reachable_locations] missing required variable= key"

        reach_param = { viewing_side: cfg.viewing_side or 0 }
        if range == "vision"
            moves = "max"
            reach_param.ignore_units = true

        reach = location_set.create()

        for i,unit in ipairs(wesmere.get_units(unit_filter))
            local unit_reach
            if moves == "max"
                saved_moves = unit.moves
                unit.moves = unit.max_moves
                unit_reach = location_set.of_pairs(wesmere.find_reach(unit, reach_param))
                unit.moves = saved_moves
            else
                unit_reach = location_set.of_pairs(wesmere.find_reach(unit, reach_param))

            if range == "vision" or range == "attack"
                unit_reach\iter( (x, y) ->
                    reach\insert(x, y)
                    for u,v in helper.adjacent_tiles(x, y)
                        reach\insert(u, v)
                )
            else
                reach\union(unit_reach)

        if location_filter
            reach = reach\filter( (x, y) ->
                return wesmere.match_location(x, y, location_filter)
            )
        reach\to_wsl_var(variable)

    scheme:
        filter:
            description: "a StandardUnitFilter. The locations reachable by any of the matching units will be stored."
        filter_location:
            "(optional) a StandardLocationFilter. Only locations which also match this filter will be stored."
        range:
            description: "possible values movement (default), attack, vision. If movement, stores the locations within the movement range of the unit, taking Zone of Control into account. If attack, stores the attack range (movement range + 1 hex). If vision, stores the vision range (movement range ignoring Zone of Control + 1 hex)."
        moves:
            description: "possible values current (default), max. Specifies whether to use the current or maximum movement points when calculating the range."

        viewing_side:
            description: "(optional) the side whose vision to use when calculating the reach. This only has meaning in the presence of fog, shroud, or units with the ambush ability. If left out, then fog, shroud and ambushers are ignored and the real reach of the units is stored."

        variable:
            description: "the name of the variable (array) into which to store the locations."
