wsl_action
    id: "set_recruit"
    description: "Sets the units a side can recruit."

    action: (cfg) ->
        recruit = cfg.recruit or wesmere.wsl_error("set_recruit missing required recruit key")
        for team in *wesmere.get_sides(cfg)
            v = for w in *recruit
                w
            team.recruit = v

    scheme:
        recruit:
            description: "the types of units that the side can now recruit."
        side:
            description: "(default=1) the number of the side that is having its recruitment set. This can be a comma-separated list. note: Default side=1 for empty side= is deprecated."
            default: 1
            type: "number"
        StandardSideFilter:
            description: "tags and keys; default for empty side= is all sides, as usual in a SSF."
