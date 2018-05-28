wsl_action
    id: "store_items"

    description: "Stores current items in the scenario into an array. Each entry has at least members x and y and can have all of the other keys listed in the documentation of [item] (depending on what was set during creating the item)."

    action: (cfg, kernel) ->
        -- locs = kernel\get_locations(cfg)
        -- items = for loc in *locs
        --     item = kernel.board.items[loc.x][loc.y]
        --     unless item
        --         continue
        --     else
        --         item
        -- return items

        variable = cfg.variable or "items"
        variable = tostring(variable or helper.wsl_error("invalid variable= in [store_items]"))
        wesmere.set_variable(variable)
        index = 0
        for i, loc in wesmere.get_locations(cfg)
            items = scenario_items[loc[1] * 10000 + loc[2]]
            continue unless items
            for item in *items
                wesmere.set_variable(string.format("%s[%u]", variable, index), item)
                index += 1

    scheme:
        variable:
            description: [[name of the wsl variable array to use (default "items")]]
            type: "string"
            default: "items"

        StandardLocationFilter:
            description: "keys as arguments: only items on locations matching this StandardLocationFilter will be stored"
