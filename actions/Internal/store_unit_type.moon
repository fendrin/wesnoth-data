wsl_action
    id: "store_unit_type"

    action: (cfg) ->
        types = cfg.type or
            wesmere.wsl_error "store_unit_type missing required type: key"

        result = for w in *types
            unit_type = wesmere.unit_types[w] or
                wesmere.wsl_error(string.format("Attempt to store nonexistent unit type '%s'.", w))

        wesmere.set_variable(cfg.variable, result)
        return result

    scheme:
        type:
            description: [[the defined ID of the unit type, for example "Goblin Knight". Do not use a translation mark or it will not work correctly for different languages. A comma-separated list of IDs may also be used to store an array of unit types.]]
            type: "string"
            is_list: true
            mandatory: true

        variable:
            description: [[the name of the variable into which to store the unit type information (default "unit_type")]]
            type: "String"
            default: "unit_type"
    return:
        description: ""
