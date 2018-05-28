wsl_action
    id: "redraw"
    description: "Redraws the screen (this normally isn't done during events, although some of the other interface actions cause the screen or parts of it to be redrawn)."

    scheme:
        clear_shroud: "(boolean yes|no, default no): If yes, clears fog and shroud around existing units. Useful if you, for example, spawn friendly units in the middle of an event and want the shroud to update accordingly (otherwise units that spawn inside fog would remain invisible for the duration of the event, since the fog would not automatically get cleared around them)."
        StandardSideFilter:
            description: "the sides for which to recalculate fog and shroud."
        side:
            description: "If used (forces clear_shroud=yes), clears fog and shroud for that side."

    action: (cfg, wesmere) ->
        clear_shroud = cfg.clear_shroud
        -- Backwards compat, the behavior of the tag was to clear shroud in case that side= is given.
        if cfg.clear_shroud == nil and cfg.side ~= nil
            clear_shroud = true

        wesmere.redraw(cfg, clear_shroud)
