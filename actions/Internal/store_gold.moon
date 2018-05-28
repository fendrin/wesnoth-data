wsl_action
    id: "store_gold"

    description: "Stores a side's gold into a variable."

    action: (cfg) ->
        side = wesmere.get_sides(cfg)[1]
        -- note: This function can't easily (without deprecation) be extended to store an array,
        -- since the gold is stored in a scalar variable, not a container (there's no key).
        if side
            gold = side.gold
            wesmere.set_variable(cfg.variable, gold)
            return gold

    scheme:
        variable:
            description: [[the name of the variable to store the gold in]]
            default: "gold_store"
            type: "string"
        StandardSideFilter:
            description: [[The first matching side's gold will be stored in the variable "variable".]]
            type: "StandardSideFilter"
            inline: true
