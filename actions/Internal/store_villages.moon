wsl_action
    id: "store_villages"
    description: [[Stores a series of locations of villages that pass certain criteria into an array. Each member of the result array will have members 'x' and 'y' (the position) and 'terrain' (the terrain type) and 'owner_side'. note: The only advantage/difference this function has, in comparison to using store_locations {terrain:"*^V*"}, is that the amount of hexes which are considered for a possible match is previously restricted to those with villages.]]

    action: (cfg) ->
        villages = wesmere.get_villages( cfg )

        result = for village in *villages
            {
                x: village[1]
                y: village[2]
                terrain: wesmere.get_terrain( village[1], village[2] )
                owner_side: wesmere.get_village_owner( village[1], village[2] ) or 0
            }

        wesmere.set_variable(cfg.variable, result)
        return result

    scheme:
        variable:
            description: [[the name of the variable (array) into which to store the locations (default: "location")]]
            type: "string"
            default: "location"
        filter_location:
            description: [[StandardLocationFilter tags and keys as arguments]]
            type: "SLF"
