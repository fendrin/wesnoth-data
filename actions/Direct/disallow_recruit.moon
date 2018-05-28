
wsl_action
    id: "disallow_recruit"
    description: "Prevents a side from recruiting units it could previously recruit."

    action: (cfg, wesmere) ->
        unit_types = cfg.type
        for team in *wesmere.get_sides(cfg)
            if unit_types
                v = team.recruit
                for w in utils.split(unit_types)
                    for i, r in ipairs(v)
                        if r == w
                            table.remove(v, i)
                            break
                team.recruit = v
            else
                team.recruit = nil

    scheme:
        type:
            description: "the types of units that the side can no longer recruit. (Version 1.13.0 and later only) If omitted, all recruits for matching sides will be disallowed."

        side:
            description: "(default: 1) the number of the side that may no longer recruit the units. This can be a comma-separated list note: Default side=1 for empty side= is deprecated."
            default: 1
        StandardSideFilter:
            description: "tags and keys; default for empty side= is all sides, as usual in a SSF."
            type: "table"
            table: "SSF"
