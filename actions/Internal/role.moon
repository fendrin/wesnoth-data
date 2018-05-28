wsl_action
    id: "role"
    description: [[Tries to find a unit to assign a role to.
This is useful if you want to choose a non-major character to say some things during the game. Once a role is assigned, you can use role: in a unit filter to identify the unit with that role (See FilterWSL).
However, there is no guarantee that roles will ever be assigned. You can use have_unit() (see ConditionWSL) to see whether a role was assigned. This table uses a StandardUnitFilter (without [filter]) with the modification to order the search by type, mark only the first unit found with the role, and the role attribute is not used in the search. If for some reason you want to search for units that have or don't have existing roles, you can use one or more not: filters. The will check recall lists in addition to units on the map. In normal use, you will probably want to include a 'side' key to force the unit to be on a particular side.]]

    action: (cfg) ->

        -- role: and type: are handled differently than in other tags,
        -- so we need to remove them from the filter
        role = cfg.role
        filter = cfg

        types = {}

        if type = cfg.type
            for value in *type
                table.insert(types, value)

        filter.role, filter.type = nil, nil

        -- first attempt to match units on the map
        for type in *types
            filter.type = type
            unit = wesmere.get_units(filter)[1]
            if unit
                unit.role = role
                return true

        -- first attempt to match units on the map
        -- i = 1
        -- repeat
        -- give precedence based on the order specified in type=
        -- if (#types > 0)
        --     filter.type = types[i]
        -- unit = wesmere.get_units(filter)[1]
        -- if unit
        --     unit.role = role
        --     return
        -- i += 1
        -- until #types == 0 or i > #types

        -- then try to match units on the recall lists
        for type in *types
            unit = wesmere.get_recall_units(filter)[1]
            if unit
                unit.role = role
                return true

        -- then try to match units on the recall lists
        -- i = 1
        -- repeat
            -- if #types > 0 then filter.type = types[i]
            -- unit = wesmere.get_recall_units(filter)[1]
            -- if unit
            --     unit.role = role
            --     return
            -- i += 1
        -- until #types == 0 or i > #types

        -- no matching unit found, issue a warning
        wesmere.message("WSL", "No matching units found in 'role'")
        return false

        --- @todo restore cfg.type to the initial value

    return:
        description: "iff the role was assigned."
        type: "bool"

    scheme:
        role:
            description: [[the value to store as the unit's role. This role is not used in the StandardUnitFilter when doing the search for the unit to assign this role to.]]
            type: "String"

        type:
            type: "Unit_type_id"
            description: [[a comma-separated list of possible types the unit can be. If any types are given, then units will be searched by type in the order listed. If no type is given, then no particular order with respect to type is guaranteed.]]

        StandardUnitFilter:
            description: "do not use a 'filter' sub-table. SUF's role: and type: keys are not used: if you want to use them, use a nested SUF wrapped inside a 'and' table."
