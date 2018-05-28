wsl_action
    id: "floating_text"
    description: "Floats text (similar to the damage and healing numbers) on the given locations."

    action: (cfg, wesmere) ->
        locs = wesmere.get_locations(cfg)
        text = cfg.text or helper.wsl_error("[floating_text] missing required text= attribute")
        for loc in *locs
            wesmere.float_label(loc[1], loc[2], text)

    scheme:
        StandardLocationFilter:
            description: "the text will be floated on all matching locations simultaneously."
        text:
            description: "the text to display."

--The default text color is #6b8cff. To change the color, use Pango markup. For example:
--# Float some golden yellow text at 20,20.
--[floating_text]
--   x,y=20,20
--   text="<span color='#cccc33'>" + _ "Your text here" + "</span>"
--[/floating_text]
