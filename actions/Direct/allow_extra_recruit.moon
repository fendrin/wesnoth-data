wsl_action
    id: "allow_extra_recruit"
    description: "Allows a leader to recruit units it couldn't previously recruit. These types add to the types the leader can recruit because of 'side.recruit'."

    action: (cfg, wesmere) ->
        recruits = cfg.extra_recruit
        for unit in *wesmere.get_units(cfg.filter)
            v = unit.extra_recruit
            for recruit in *recruits
                table.insert(v, recruit)
                wesmere.add_known_unit(recruit)

    scheme:
        extra_recruit:
            description: "the types of units that the unit can now recruit."
            mandatory: true

        filter:
            description: "StandardUnitFilter: All units matching this filter are modified. Does not match on recall list units."
            type: "table"
            table: "StandardUnitFilter"
