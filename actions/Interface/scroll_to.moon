wsl_action
    id: "scroll_to"
    description: "Scroll to a given hex"

    scheme: [[
x, y: the hex to scroll to
StandardLocationFilter, do not use a [filter_location] sub-tag. If more than one location matches the filter, only the first matching location will be used.
check_fogged: whether to scroll even to locations covered in fog or shroud. Possible values true (don't scroll to fog) and false (scroll even to fog), with false as the default.
immediate: whether to instantly warp to the target hex regardless of the scroll speed setting in Preferences (defaults to false).
side: the side or sides for which this should happen. By default, the [scroll_to] happens for everyone.
[filter_side]: a StandardSideFilter to select the sides for which this should happen. By default, the [scroll_to] happens for everyone.]]

    action: (cfg, wesmere) ->
        loc = wesmere.get_locations( cfg )[1]
        return unless loc
        return unless utils.optional_side_filter(cfg)
        wesmere.scroll_to_tile(loc[1], loc[2], cfg.check_fogged, cfg.immediate)
