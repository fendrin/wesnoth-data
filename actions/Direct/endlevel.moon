wsl_action
    id: "endlevel"
    description: "Ends the scenario."

    action: (cfg) ->

        if wesmere.is_regular_game_end
            wesmere.message("Repeated [endlevel] execution, ignoring")
            return

        next_scenario = cfg.next_scenario
        if next_scenario
            wesmere.set_next_scenario(next_scenario)

        -- end_text = cfg.end_text
        -- end_text_duration = cfg.end_text_duration
        -- if end_text or end_text_duration
        --     wesmere.set_end_campaign_text(end_text or "", end_text_duration)

        -- end_credits = cfg.end_credits
        -- if end_credits ~= nil
        --     wesmere.set_end_campaign_credits(end_credits)

        -- side_results = {}
        -- results = wrapInArray(cfg.result)
        -- for result in *results
        --     wesmere.debug result
        --     side = result.side or wesmere.wsl_error("[result] in [endlevel] missing required 'side:' key")
        --     side_results[side] = result

        there_is_a_human_victory = false
        there_is_a_human_defeat = false
        there_is_a_local_human_victory = false
        there_is_a_local_human_defeat = false
        bool_int = (b) ->
            if b == true
                return 0
            elseif b == false
                return 1
            else
                return b

        -- for side in *wesmere.sides
        --     side_result = side_results[side.side] or {}
        --     victory_or_defeat = side_result.result or cfg.result or "victory"
        --     victory = victory_or_defeat == "victory"
        --     if victory_or_defeat ~= "victory" and victory_or_defeat ~= "defeat"
        --         return helper.wsl_error("invalid result= key in [endlevel] '" .. victory_or_defeat .."'")

        --     if side.controller == "human" or side.controller == "network"
        --         if victory
        --             there_is_a_human_victory = true
        --         else
        --             there_is_a_human_defeat = true

        --     if side.controller == "human"
        --         if victory
        --             there_is_a_local_human_victory = true
        --         else
        --             there_is_a_local_human_defeat = true

        --     if side_result.bonus ~= nil
        --         side.carryover_bonus = bool_int(side_result.bonus)
        --     elseif cfg.bonus ~= nil
        --         side.carryover_bonus = bool_int(cfg.bonus)

        --     if side_result.carryover_add ~= nil
        --         side.carryover_add = side_result.carryover_add
        --     elseif cfg.carryover_add ~= nil
        --         side.carryover_add = cfg.carryover_add

        --     if side_result.carryover_percentage ~= nil
        --         side.carryover_percentage = side_result.carryover_percentage
        --     elseif cfg.carryover_percentage ~= nil
        --         side.carryover_percentage = cfg.carryover_percentage

        -- proceed_to_next_level = there_is_a_human_victory or (not there_is_a_human_defeat and cfg.result ~= "defeat")
        victory = there_is_a_local_human_victory or (not there_is_a_local_human_defeat and proceed_to_next_level)

        wesmere.end_level
            music: cfg.music
            carryover_report: cfg.carryover_report
            save: cfg.save
            replay_save: cfg.replay_save
            linger_mode: cfg.linger_mode
            reveal_map: cfg.reveal_map
            proceed_to_next_level: proceed_to_next_level
            result: cfg.result --victory and "victory" or "defeat"

    scheme:
        result:
            description: [[before the scenario is over, all events with name=result are triggered. If result=victory, the player progresses to the next level (i.e., the next scenario in single player); if result=defeat, the game returns to the main menu.]]
            type: "enum"
            enum: {"victory", "defeat"}

-- When the result is "victory" the following keys can be used:

        bonus:
            description: [[whether the player should get bonus gold (maximum possible gold that could have been earned by waiting the level out). The default is bonus=yes.]]
            default: true
            type: "Bool"

        carryover_report:
            description: [[whether the player should receive a summary of the scenario outcome, the default is carryover_report=yes.]]
            default: true
            type: "Bool"

        save:
            description: [[whether a start-of-scenario save should be created for the next scenario, the default is save=yes. Do not confuse this with saving of replays for the current scenario.]]
            default: true
            type: "Bool"

        replay_save:
            description: [[whether a replay save for the current scenario is allowed, the default is replay_save=yes. If yes, the player's settings in preferences will be used to determine if a replay is saved. If no, will override and not save a replay.]]
            default: true
            type: "Bool"


        linger_mode:
            description: [[If ...=yes, the screen is greyed out and there's the possibility to save before advancing to the next scenario, the default is linger_mode=yes.]]
            default: true
            type: "Bool"

        reveal_map:
            description: [[(Multiplayer only) (Default is 'yes') If 'no', shroud doesn't disappear when game ended.]]
            default: true
            type: "Bool"

        next_scenario:
            description: [[(default specified in [scenario] table) the ID of the next scenario that should be played. All units that side 1 controls at this point become available for recall in next_scenario.]]

        carryover_percentage:
            description: [[by default 80% of the gold is carried over to the next scenario, with this key the amount can be changed.]]
            default: 80
            type: "%"

        carryover_add:
            description: [[if true the gold will be added to the starting gold the next scenario, if false the next scenario will start with the amount of the current scenario (after taxes) or the minimum in the next scenario. Default is false.]]
            default: false
            type: "Bool"

        music:
            description: [[(default specified in [scenario] or [game_config] tags) a comma-separated list of music tracks from which one will be chosen and played once after any events related to the end of level result are executed; by default, victory_music is used on victory, and defeat_music on defeat.]]

        end_credits:
            description: [[Whether to display the credits screen at the end of a single-player campaign. Defaults to yes. Note that this has cumulative effects over the campaign - it persists even if the endlevel does not trigger the end of the campaign. See also CampaignWSL.]]

        end_text:
            description: [[(translatable) Text that is shown centered in a black screen at the end of a campaign. Defaults to "The End". Note that this has cumulative effects over the campaign - it persists even if the endlevel does not trigger the end of the campaign. See also CampaignWSL.]]
            type: "tString"

        end_text_duration:
            description: [[Delay, in milliseconds, before displaying the game credits at the end of a campaign. In other words, for how much time end_text is displayed on screen. Defaults to 3500. Note that this has cumulative effects over the campaign - it persists even if the endlevel does not trigger the end of the campaign. See also CampaignWSL.]]
            type: "Signed"
            default: 3500

        next_scenario_settings:
            description: [[Any tags or attribute children of this optional argument to [endlevel] are merged into the scenario/multiplayer tag of the *next* scenario. This allows you to e.g. reconfigure the [side] tags or settings, just before load. This feature was removed in 1.11.17, it might be redesigned and reintroduced.]]

        next_scenario_append:
            description: [[Any tags of this optional argument are appended at high level to the next scenario. This is most appropriate for [event] tags, although you may find other uses. Example test scenario for these features: https://gna.org/support/download.php?file_id=20119 This feature was removed in 1.11.17, it might be redesigned and reintroduced.]]

        result:
            type: "Table"
            description: [[(Version 1.13.0 and later only) Allows specification of a side specific result, this is for competitive multiplayer scenarios/campaigns where it might happen that one player wins but another player loses. The following attributes are accepted and have the same effect as in [endlevel]:]]
            scheme:
                result:
                    description: ""
                bonus:
                    description: ""
                carryover_percentage:
                    description: ""
                carryover_add:
                    description: ""
        -- And there is also
                side:
                    description: [[The number of the side for which these results should apply.]]
                    type: "Signed"
