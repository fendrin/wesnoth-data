
wsl_action
    id: "reset_fog"

    action: (cfg, kernel) ->
        kernel\print("'reset_fog' not implemented yet.")

    description: [[The primary use of this tag is to remove multiturn lifted fog (created by [lift_fog]), which causes the fog to reset to what it would have been had WSL not interfered. (That is, hexes that a side's units could not see at any point this turn will be re-fogged, while seen hexes remain defogged.)
Omitting both the SSF and the SLF would cancel all earlier uses of [lift_fog]. Additionally setting reset_view="yes" would cause the side's entire map to be fogged (unless an ally keeps hexes clear by sharing its view).]]

    scheme:
        filter_side:
            description: "with a StandardSideFilter indicating which sides should be affected."

        StandardLocationFilter:
            description: "the fog reset will be restricted to these tiles."

        reset_view:
            description: [[yes/no, default: no If set to "yes", then in addition to removing multiturn fog, the side's current view is canceled (independent of the SLF). This means that all hexes will become fogged for the side unless multiturn fog exists outside the tiles selected by the SLF. Normally, one would want the currently seen hexes to become clear of fog; this is done automatically at the end of many events, and it can be done manually with [redraw].]]
