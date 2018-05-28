wsl_action
    id: "disallow_extra_recruit"
    description: "Prevents a leader from recruiting units it could previously recruit."

    action: (cfg, kernel) ->
        recruits = cfg.extra_recruit or helper.wsl_error("[disallow_extra_recruit] missing required extra_recruit= attribute")
        for unit in *wesmere.get_units(cfg)
            v = unit.extra_recruit
            for w in *recruits
                for i, r in ipairs(v)
                    if r == w
                        table.remove(v, i)
                        break
            unit.extra_recruit = v

    scheme:
        extra_recruit:
            description: "the types of units that the side can no longer recruit."

        StandardUnitFilter:
            description: "All units matching this filter are modified. Does not match on recall list units."
