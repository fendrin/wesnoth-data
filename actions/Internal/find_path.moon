wsl_action
    id: "find_path"
    description: [[A WSL interface to the pathfinder. Calculates the path between a unit and a location and returns the result in a WSL variable, that contains also an array for every step of the path.

This is the structure of the variable returned by [find_path]:
[path]
	hexes = the total length of the path
		if the path is calculated to an impassable hex, or the move requires multiple turns
		and allow_multiple_turns is no, its value will be 0.
	from_x, from_y = location of the unit
	to_x, to_y = destination
	movement_cost = total movement cost required by unit to reach that hex
	required_turns = total turns required by unit to reach that hex
	[step]
		x, y = location of the step
		terrain = terrain of the step
		movement_cost = movement cost required by unit to reach that hex
		required_turns = turns required by unit to reach that hex]]

    action: (cfg, kernel) ->

        filter_unit = cfg.traveler

        -- only the first unit matching
        unit = wesmere.get_units(filter_unit)[1] or helper.wsl_error("[find_path]'s filter didn't match any unit")
        filter_location = cfg.destination

        -- support for $this_unit
        this_unit = utils.start_var_scope("this_unit")

        wesmere.set_variable( "this_unit" ) -- clearing this_unit
        wesmere.set_variable("this_unit", unit.__cfg) -- cfg field needed

        variable = cfg.variable or "path"
        ignore_units = false
        ignore_teleport = false

        if cfg.check_zoc == false --if we do not want to check the ZoCs, we must ignore units
            ignore_units = true

        if cfg.check_teleport == false --if we do not want to check teleport, we must ignore it
            ignore_teleport = true

        allow_multiple_turns = cfg.allow_multiple_turns
        local viewing_side

        unless cfg.check_visibility then viewing_side = 0 -- if check_visiblity then shroud is taken in account

        locations = wesmere.get_locations(filter_location) -- only the location with the lowest distance and lowest movement cost will match. If there will still be more than 1, only the 1st maching one.
        max_cost = nil
        unless allow_multiple_turns then max_cost = unit.moves --to avoid wrong calculation on already moved units
        current_distance, current_cost = math.huge, math.huge
        current_location = {}

        width, heigth, border = wesmere.get_map_size! -- data for test below

        -- for index, location in ipairs(locations)
        --     -- we test if location passed to pathfinder is invalid (border); if is, do nothing, do not return and continue the cycle
        --     if location[1] == 0 or location[1] == ( width + 1 ) or location[2] == 0 or location[2] == ( heigth + 1 ) then
        --     else
        --         distance = helper.distance_between ( unit.x, unit.y, location[1], location[2] )
        --         -- if we pass an unreachable locations an high value will be returned
        --         path, cost = wesmere.find_path( unit, location[1], location[2], { max_cost = max_cost, ignore_units = ignore_units, ignore_teleport = ignore_teleport, viewing_side = viewing_side } )

        --         if ( distance < current_distance and cost <= current_cost ) or ( cost < current_cost and distance <= current_distance ) -- to avoid changing the hex with one with less distance and more cost, or vice versa
        --             current_distance = distance
        --             current_cost = cost
        --             current_location = location

        -- if #current_location == 0
        --     wesmere.message("WSL warning","[find_path]'s filter didn't match any location")
        -- else
        --     path, cost = wesmere.find_path( unit, current_location[1], current_location[2], { max_cost: max_cost, ignore_units: ignore_units, ignore_teleport: ignore_teleport, viewing_side: viewing_side } )
        --     local turns

        --     if cost == 0 -- if location is the same, of course it doesn't cost any MP
        --         turns = 0
        --     else
        --         turns = math.ceil( ( ( cost - unit.moves ) / unit.max_moves ) + 1 )


        --     if cost >= 42424242 -- it's the high value returned for unwalkable or busy terrains
        --         wesmere.set_variable( string.format("%s", variable), { hexes: 0 } ) -- set only length, nil all other values
        --         -- support for $this_unit
        --         wesmere.set_variable ( "this_unit" ) -- clearing this_unit
        --         utils.end_var_scope("this_unit", this_unit)
        --     return

        --     unless allow_multiple_turns and turns > 1 then -- location cannot be reached in one turn
        --         wesmere.set_variable( string.format("%s", variable), { hexes: 0 } )
        --         -- support for $this_unit
        --         wesmere.set_variable ( "this_unit" ) -- clearing this_unit
        --         utils.end_var_scope("this_unit", this_unit)
        --     return -- skip the cycles below

        --     wesmere.set_variable( string.format( "%s", variable ), { hexes: current_distance, from_x: unit.x, from_y:  unit.y, to_x: current_location[1], to_y: current_location[2], movement_cost: cost, required_turns: turns } )

        --     for index, path_loc in ipairs(path)
        --         sub_path, sub_cost = wesmere.find_path( unit, path_loc[1], path_loc[2], { max_cost: max_cost, ignore_units: ignore_units, ignore_teleport: ignore_teleport, viewing_side: viewing_side } )
        --         local sub_turns

        --         if sub_cost == 0
        --             sub_turns = 0
        --         else
        --             sub_turns = math.ceil( ( ( sub_cost - unit.moves ) / unit.max_moves ) + 1 )

        --         wesmere.set_variable( string.format( "%s.step[%d]", variable, index - 1 ), { x: path_loc[1], y: path_loc[2], terrain: wesmere.get_terrain( path_loc[1], path_loc[2] ), movement_cost: sub_cost, required_turns: sub_turns } ) -- this structure takes less space in the inspection window

        -- support for $this_unit
        wesmere.set_variable ( "this_unit" ) -- clearing this_unit
        utils.end_var_scope("this_unit", this_unit)

    scheme:
        traveler:
            description: [[StandardUnitFilter, only the first matching unit will be used for calculation]]
            mandatory: true

        destination:
            description: [[StandardLocationFilter, only the first matching nearest hex will be used]]

        variable:
            description: [[the variable name where the result will be stored, if no value is supplied 'path' will be used as default name. Each step will be stored in a [step] array inside that variable.]]

        allow_multiple_turns:
            description: [[default no, if yes also moves that require more than one turn will be calculated.]]

        check_visibility:
            description: [[default no, if yes the path will not be computed if some hexes are not visible due to shroud.]]

        check_teleport:
            description: [[default yes, if no teleport won't be taken in account while computing path.]]

        check_zoc:
            description: [[default yes, if no unit ZOCs won't be considered while calculating the path.]]
