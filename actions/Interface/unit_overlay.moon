wsl_action
    id: "unit_overlay"
    description: "Sets an image that will be drawn over a particular unit, and follow it around"

    scheme:
        StandardUnitFilter:
            description: "All matching units will get the overlay (do not use [filter])"
        image:
            description: "the image to place on the unit"

    action: (cfg, wesmere) ->
        img = cfg.image or helper.wsl_error( "[unit_overlay] missing required image= attribute" )
        for u in *wesmere.get_units(cfg)
            ucfg = u.__cfg
            for w in *ucfg.overlays
                if w == img then ucfg = nil

            if ucfg
                ucfg.overlays = ucfg.overlays .. ',' .. img
                wesmere.put_unit(ucfg)
