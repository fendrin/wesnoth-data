wsl_action
    id: "label"
    description: "Places a label on the map."

    action: (cfg, kernel) ->

        new_cfg = helper.parsed( cfg )
        for location in *wesmere.get_locations(cfg)
            new_cfg.x, new_cfg.y = location[1], location[2]
            wesmere.label( new_cfg )

        -- locs = kernel\get_locs(cfg.filter_location)
        -- labels = if team = cfg.team_id
        --     kernel.game_state.teams[team].labels
        -- else
        --     kernel.board.labels
        -- label =
        --     text: cfg.text
        --     color: cfg.color
        --     visible_in_fog: cfg.visible_in_fog
        --     visible_in_shroud: cfg.visible_in_shroud
        --     immutable: cfg.immutable
        -- for loc in *locs
        --     labels[loc\x!][loc\y!] = label

    scheme:
        --loc:
        --x, y: the location of the label. (Version 1.13.1 and later only) (only for [event][label]: full SLF support)
        text:
            description: [[what the label should say]]
            type: "tString"
            mandatory: true
        team_id:
            description: [[if specified, the label will only be visible to the given team.]]
            type: "String"
        color:
            description: [[color of the label. The format is r,g,b; r, g and b are numbers between 0 and 255.]]
            type: "String"
        visible_in_fog:
            description: [[whether the label should be visible through fog or not. Default yes.]]
            type: "Bool"
            default: true
        visible_in_shroud:
            description: [[whether the label should be visible through shroud or not. Default no.]]
            type: "Bool"
            default: false
        immutable:
            description: [[whether this label is protected from being removed or changed by players. Default yes.]]
            type: "Bool"
            default: true

