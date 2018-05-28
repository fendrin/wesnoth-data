wsl_action
    id: "remove_item"
    description: "Removes any graphical items on a given hex."

    scheme:
        StandardLocationFilter:
            description: "the hexes to remove items off"
        image: "if specified, only removes the given image item (This image name must include any image path functions appended to the original image name.)"

    action: (cfg, wesmere) ->
        locs = wesmere.get_locations(cfg)
        for loc in *locs
            remove_overlay(loc[1], loc[2], cfg.image)
