id = "store_locations"

wsl_action
    id: id
    description: [[Stores a series of locations that pass certain criteria into an array. Each member of the array has members 'x' and 'y' (the position) and 'terrain' (the terrain type) and 'owner_side' (villages only). The array will include any unreachable border hexes, if applicable.]]

    action: (cfg) ->
        local locs
        try
            do: -> locs = wesmere.get_locations(cfg)
            catch: (err) -> error "WSLAction #{id}: #{err}"
        result = for loc in *locs
            X = loc.x
            Y = loc.y
            {
                x: X
                y: Y
                terrain: wesmere.get_terrain(X, Y)
                owner_side: wesmere.get_village_owner(X, Y) or 0
                unit: wesmere.get_unit(X, Y)
            }
        if variable = cfg.variable
            wesmere.set_variable(variable, result)
        return result

        -- the variable can be mentioned in a [find_in] subtag, so it
        -- cannot be cleared before the locations are recovered

    scheme:
        variable:
            description: [[the name of the variable (array) into which to store the locations.]]
            type: "string"
        filter_location:
            description: [[StandardLocationFilter: a location or location range which specifies the locations to store. By default, all locations on the map are stored.]]
            type:{"table","function"}



