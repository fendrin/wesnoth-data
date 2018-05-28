wsl_action
    id: "gold"
    description: "Gives sides gold."

    action: (cfg) ->
        assert(cfg.amount)
        sides = wesmere.get_sides(cfg)
        for side in *sides
            side.gold += cfg.amount

    scheme:
        amount:
            description: "the amount of gold to give."
            type: "number"
            mandatory: true
        filter_side:
            description: "(default=1) the number of the side to give the gold to. Can be a comma-separated list of sides. note: Default side=1 for empty side= is deprecated. StandardSideFilter: tags and keys; default for empty side= is all sides, as usual in a SSF."
