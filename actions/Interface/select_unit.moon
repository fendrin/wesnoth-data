wsl_action
    id: "Selects a given unit."

    action: (cfg, wesmere) ->
        u = wesmere.get_units(cfg)[1]
        unless u then return
        wesmere.select_hex(u.x, u.y, cfg.highlight, cfg.fire_event)

    scheme:
        StandardUnitFilter: "The first unit found will be selected."
        fire_event:
            description: "whether a select event should be triggered or not (def. no). (Note that select events aren't multiplayer save.)"
        highlight:
            description: "whether the unit's current hex should be highlighted (def. yes)."
