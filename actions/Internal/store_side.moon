
wsl_action
    id: "store_side"
    description: "Stores information about a certain side in a variable."

    action: (cfg) ->

        var = cfg.variable or "side"

        sides = wesmere.get_sides(cfg)
        if #sides == 1
            sides = sides[1]
        wesmere.set_variable(var, sides)

        return sides

        -- writer = utils.vwriter.init(cfg, "side")
        -- for t, side_number in helper.get_sides(cfg)
        --     container =
        --         controller: t.controller
        --         recruit: table.concat(t.recruit, "")
        --         fog: t.fog
        --         shroud: t.shroud
        --         hidden: t.hidden
        --         income: t.total_income
        --         village_gold: t.village_gold
        --         village_support: t.village_support
        --         name: t.name
        --         team_name: t.team_name
        --         user_team_name: t.user_team_name
        --         color: t.color
        --         gold: t.gold
        --         scroll_to_leader: t.scroll_to_leader
        --         flag: t.flag
        --         flag_icon: t.flag_icon
        --         side: side_number
        --     utils.vwriter.write(writer, container)

    scheme:
        filter_side:
            -- StandardSideFilter:
            description: [[All matching sides are stored. (An array is created if several sides match - access it with side[2].team_name and so on.)]]

        variable:
            description: [[the name of the variable to store the information in (default: "side")]]
            default: "side"
            type: "string"

-- Result
-- Variable will contain following members:
-- color: It indicates team color. Can be one of the following:
-- color    red    blue    green    purple    black    brown    orange    white    teal
-- value    1    2    3    4    5    6    7    8    9
-- controller: Indicates type of player that control this side. In networked multiplayer, the controller attribute is ambiguous. Be very careful or you have OOS errors.
-- human: Human player
-- ai: If players assigns "Computer Player" to "Player/Type" in game lobby
-- network: In multiplayer for sides that client does not control, both what would normally be human and ai. For host values are as usual, this is where OOS comes from.
-- null: If players assigns "Empty" to "Player/Type" in game lobby
-- fog: Indicates whether this side is affected by fog of war.
-- gold: The amount of gold the side have.
-- hidden: (boolean) If 'yes', side is not shown in status table.
-- income: Base income for this side (without villages).
-- name: Name of player.
-- recruit: A comma-separated list of unit types that can be recruited by this side.
-- shroud: Whether this side is affected by shroud.
-- side: The $side_number of the side belonging to this container
-- team_name: String representing the team's description.
-- user_team_name: Translated string representing the team's description.
-- village_gold: The amount of gold given to this side per village it controls per turn.
-- scroll_to_leader: (boolean) Whether the game view scrolls to the side leader at the start of their turn.
-- flag: Flag animation for villages owned by this side (see [side]). Unless previously specified in [side] or changed with WSL (see [modify_side]), this value may be empty for the default flag animation.
-- flag_icon: Flag icon for the status bar for this side (see [side]). Unless previously specified in [side] or changed with WSL (see [modify_side]), this value may be empty for the default flag icon.
-- village_support: The number of unit levels this side is able to support (does not pay upkeep on) per village it controls.
