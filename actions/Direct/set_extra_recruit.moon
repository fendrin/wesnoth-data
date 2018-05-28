wsl_action
    id: "set_extra_recruit"
    description: "Sets the units a leader can recruit."

    action: (cfg, kernel) ->
        recruits = cfg.extra_recruit or helper.wsl_error("[set_extra_recruit] missing required extra_recruit= attribute")
        v = for w in utils.split(recruits)
            w
        for unit in *wesmere.get_units(cfg)
            unit.extra_recruit = v

    scheme:
        extra_recruit:
            description: "the types of units that the leader can now recruit."
        StandardUnitFilter:
            description: "All units matching this filter are modified. Does not match on recall list units."
