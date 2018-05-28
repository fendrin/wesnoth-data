wsl_action
    id: "terrain"
    description: [[Changes the terrain on the map.
Note: When a hex changes from a village terrain to a non-village terrain, and a team owned that village it loses that village. When a hex changes from a non-village terrain to a village terrain and there is a unit on that hex it does not automatically capture the village. The reason for not capturing villages it that there are too many choices to make; should a unit loose its movement points, should capture events be fired. It is easier to do this as wanted by the author in WSL.]]

    action: (cfg, kernel) ->
        for loc in *wesmere.get_locations(cfg.filter)
            wesmere.set_terrain(loc[1], loc[2], cfg.terrain, cfg.layer, cfg.replace_if_failed)

    scheme:
        terrain:
            description: "the string of the terrain to use. See TerrainCodesWSL to see what string a type of terrain uses."
            type: "terrain_string"
            mandatory: true
        filter:
            description: "StandardLocationFilter"
            type: "SLF"
        layer:
            description: "(overlay|base|both, default=both) only change the specified layer."
            enum: { "overlay", "base", "both" }
            default: "both"
            type: "Enum"
        replace_if_failed:
            description: [[When replacing just one layer failed, try to replace the whole terrain. If terrain is an overlay only terrain, use the default_base as base layer. If the terrain has no default base, do nothing.
If you want to remove the overlays from a terrain and leave only the base, use:
layer: "overlay"
terrain: "^"]]
            type: "Bool"
            default: false
