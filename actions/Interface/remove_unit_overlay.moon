wsl_action
    id: "remove_unit_overlay"
    description: "removes a particular overlayed image from a unit"

    scheme:
        StandardUnitFilter: "The overlay will get removed from all matching units (do not use [filter])"
        image: "the image to remove from the unit"

    action: (cfg, wesmere) ->
        img = cfg.image or helper.wsl_error( "[remove_unit_overlay] missing required image= attribute" )
        -- Loop through all matching units.
        for i,u in ipairs(wesmere.get_units(cfg))
            ucfg = u.__cfg
            t = utils.parenthetical_split(ucfg.overlays)
            -- Remove the specified image from the overlays.
            for i = #t,1,-1
                if t[i] == img then table.remove(t, i)
            -- Reassemble the list of remaining overlays.
            ucfg.overlays = table.concat(t, ',')
            wesmere.put_unit(ucfg)
