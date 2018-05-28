
wsl_action
    id: "modify_side"
    description: "Modifies some details of a given side in the middle of a scenario. The following listed properties are the only properties that [modify_side] can affect!"

    action: (cfg) ->

        assert(wesmere.sides)

        modify_side = (side) ->
            assert(side)
            with side
                if income = cfg.income
                    .income = income
                if gold = cfg.gold
                    .gold = gold

        side = cfg.side or 1
        if filter = cfg.filter_side
            sides = wesmere.get_sides(filter)
            for side in *sides
                modify_side(side)
        else
            side = wesmere.sides[side]
            assert(side)
            modify_side(side)

    scheme:
        side:
            description: "the number of the side that is to be changed. note: Default side=1 for empty side= is deprecated."
            default: 1
            type: "number"
        filter_side:
            description: "with a StandardSideFilter as argument"
            type: "table"
            table: "SSF"
            inline: true
        income:
            description: "the income given at the begining of each turn."

        recruit:
            description: "a list of unit types, replacing the side's current recruitment list."

        team_name:
            description: "the team in which the side plays the scenario."
        user_team_name:
            description: "a translatable string representing the team's description. This has no effect on alliances. Defaults to team_name."
        gold:
            description: "the amount of gold the side owns."
        village_gold:
            description: "the income setting per village for the side."
        controller:
            description: "the identifier string of the side's controller. Uses the same syntax of the controller key in the [side] tag."
        fog:
            description: "a boolean string (yes/no) describing the status of Fog for the side."
        shroud:
            description: "a boolean string describing the status of Shroud for the side."
        hidden:
            description: "a boolean string specifying whether side is shown in status table."
        color:
            description: [[a team color range specification, name (e.g. "red", "blue"), or number (e.g. "1", "2") for this side. The default color range names, numbers, and definitions can be found in data/core/team_colors.cfg.]]
        ai:
            description: "sets/changes AI parameters for the side. Only parameters that are specified in the tag are changed, this does not reset others to their default values. Uses the same syntax as described in AiWSL. Note that [modify_side][ai] works for all simple AI parameters and some, but not all, of the composite ones. If in doubt, use [modify_ai] instead, which always works."

        switch_ai:
            description: "replaces a side ai with a new AI from specified file(ignoring those AI parameters above). Path to file follows the usual WSL convention."
        reset_maps:
            description: "If set to 'true', then the shroud is spread to all hexes, covering the parts of the map that had already been explored by the side, including hexes currently seen. (Seen hexes will be cleared at the end of most events; they can also be manually cleared with [redraw].) This is only effective if shroud is on, but this is evaluated after shroud= (and before shroud_data=)."
        reset_view:
            description: "If set to 'true', then the fog of war is spread to all hexes, covering the parts of the map that had already been seen this turn by the side, including hexes currently seen, excluding hexes affected by multi-turn [lift_fog]. (Seen hexes will be cleared at the end of most events; they can also be manually cleared with [redraw].) This is only effective if fog is on, but this is evaluated after fog=."
        share_maps:
            description: "change the share_maps side attribute. Be sure to use shroud=yes for that side and have it as an ally"
        share_view:
            description: "change the share_view side attribute. Be sure to use fog=yes for that side and have it as an ally"
        shroud_data:
            description: "changes to the side's shroud, using the same format as when defining the [side]."
        suppress_end_turn_confirmation:
            description: "Boolean value controlling whether or not a player is asked for confirmation when skipping a turn."
        scroll_to_leader:
            description: "Boolean value controlling whether or not the game view scrolls to the side leader at the start of their turn when present."
        flag:
            description: "Flag animation for villages owned by this side (see [side])."
        flag_icon:
            description: "Flag icon used for this side in the status bar (see [side])."
        village_support:
            description: "The number of unit levels this side is able to support (does not pay upkeep on) per village it controls."
