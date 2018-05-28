wsl_action
    id: "scroll_to_unit"
    description: "Scroll to a given unit"

    scheme:
        StandardUnitFilter:
            description: "blah"
        check_fogged: "whether to scroll even to locations covered in fog or shroud. Possible values true (don't scroll to fog) and false (scroll even to fog), with false as the default."
        immediate:
            description: "whether to instantly warp to the target hex regardless of the scroll speed setting in Preferences (defaults to false)."
        for_side:
            description: "the side or sides for which this should happen. By default, the [scroll_to_unit] happens for everyone."
        for_side:
            description: "a StandardSideFilter to select the sides for which this should happen. By default, the [scroll_to_unit] happens for everyone."

    action: (cfg, wesmere) ->
        u = wesmere.get_units(cfg)[1]
        return unless u
        return unless utils.optional_side_filter(cfg, "for_side", "for_side")
        wesmere.scroll_to_tile(u.x, u.y, cfg.check_fogged, cfg.immediate)
