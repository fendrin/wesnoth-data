

wsl_action
    id: "hide_unit"
    description: [[Temporarily prevents the engine from displaying the given unit. The unit does not become invisible, as it would be with the [hides] ability; it is still the same plain unit, but without an image. Useful in conjunction with [move_unit_fake]: to move a leader unit into position on-screen. Until 1.8 each [hide_unit] tag only hides one unit.
StandardUnitFilter: All matching units will be hidden]]

    action: (cfg, kernel) ->
        for u in *wesmere.get_units(cfg)
            u.hidden = true
        wsl_actions.redraw {}

        -- units = kernel\get_units(cfg.filter)
        -- for unit in *units
        --     kernel\send_request("hide_unit", unit\loc!)
