wsl_action
    id: "store_unit_type_ids"

    scheme:
        variable:
            description: "the name of the variable into which to store a comma-separated list of all unit type IDs including all from all loaded addons"
            default:"unit_type_ids"
            type:"string"

    action: (cfg) ->
        types = for k,v in pairs(wesmere.unit_types)
            k
        table.sort(types)
        types = table.concat(types, ',')
        wesmere.set_variable(cfg.variable or "unit_type_ids", types)
