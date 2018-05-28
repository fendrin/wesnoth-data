wsl_action
    id: "unhide_unit"
    description: "Stops the currently hidden units from being hidden."

    scheme:
        StandardUnitFilter:
            description: "Only the matching units will be unhidden"

    action: (cfg, wesmere) ->
        for u in *wesmere.get_units(cfg)
            u.hidden = false
        wsl_actions.redraw {}
