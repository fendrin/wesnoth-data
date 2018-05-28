
wsl_action
    id: "objectives"

    description: [[The other tag used for plot development is [objectives]. The [objectives] tag overwrites any previously set objectives, and displays text which should describe the objectives of the scenario. Scenario objectives are displayed on the player's first turn after the tag is used, or as part of the event if it triggers during that player's turn. Objectives can also be accessed at any time in a scenario using the "Scenario Objectives" game menu option, making this tag useful for scenario-specific information that the player may need to refer to during play.]]

    action: (cfg, wesmere) ->
        sides = wesmere.get_sides(cfg)
        silent = cfg.silent

        remove_ssf_info_from(cfg)
        cfg.silent = nil

        objectives = generate_objectives(cfg)

        set_objectives = (sides, save) ->
            for side in *sides
                if save then scenario_objectives[side.side] = cfg
                side.objectives = objectives
                side.objectives_changed = not silent

        if #sides == #wesmere.sides or #sides == 0
            scenario_objectives[0] = cfg
            set_objectives(wesmere.sides)
        else
            set_objectives(sides, true)

--------------------------------------------------------------

        -- local helper = wesmere.require "lua/helper.lua"
        -- local wsl_actions = wesmere.wsl_actions
        -- local game_events = wesmere.game_events

        -- local function color_prefix(r, g, b)
        --     return string.format('<span foreground="#%02x%02x%02x">', r, g, b)
        -- end

        -- local function insert_before_nl(s, t)
        --     return string.gsub(tostring(s), "[^\n]*", "%0" .. t, 1)
        -- end

        -- local scenario_objectives = {}

        -- local old_on_save = game_events.on_save
        -- function game_events.on_save()
        --     local custom_cfg = old_on_save()
        --     for i,v in pairs(scenario_objectives) do
        --         v.side = i
        --         table.insert(custom_cfg, { "objectives", v })
        --     end
        --     return custom_cfg
        -- end

        -- local old_on_load = game_events.on_load
        -- function game_events.on_load(cfg)
        --     for i = #cfg,1,-1 do
        --         local v = cfg[i]
        --         if v[1] == "objectives" then
        --             local v2 = v[2]
        --             scenario_objectives[v2.side or 0] = v2
        --             table.remove(cfg, i)
        --         end
        --     end
        --     old_on_load(cfg)
        -- end

        -- local function generate_objectives(cfg)
        --     -- Note: when changing the text formatting, remember to check if you also
        --     -- need to change the hardcoded default multiplayer objective text in
        --     -- multiplayer_connect.cpp.

        --     local _ = wesmere.textdomain("wesmere")
        --     local objectives = ""
        --     local win_objectives = ""
        --     local lose_objectives = ""
        --     local gold_carryover = ""
        --     local notes = ""

        --     local win_string = cfg.victory_string or _ "Victory:"
        --     local lose_string = cfg.defeat_string or _ "Defeat:"
        --     local gold_carryover_string = cfg.gold_carryover_string or _ "Gold carryover:"
        --     local notes_string = cfg.notes_string or _ "Notes:"

        --     local bullet = cfg.bullet or "&#8226; "

        --     for obj in helper.child_range(cfg, "objective") do
        --         local show_if = helper.get_child(obj, "show_if")
        --         if not show_if or wesmere.eval_conditional(show_if) then
        --             local objective_bullet = obj.bullet or bullet
        --             local condition = obj.condition
        --             local description = obj.description or ""
        --             local turn_counter = ""

        --             if obj.show_turn_counter then
        --                 local current_turn = wesmere.current.turn
        --                 local turn_limit = wesmere.game_config.last_turn

        --                 if turn_limit >= current_turn then
        --                     if turn_limit - current_turn + 1 > 1 then
        --                         turn_counter = "<small> " .. string.format(tostring(_"(%d turns left)"), turn_limit - current_turn + 1) .. "</small>"
        --                     else
        --                         turn_counter = "<small> " .. _"(this turn left)" .. "</small>"
        --                     end
        --                 end
        --             end

        --             if condition == "win" then
        --                 local caption = obj.caption
        --                 local r = obj.red or 0
        --                 local g = obj.green or 255
        --                 local b = obj.blue or 0

        --                 if caption then
        --                     win_objectives = win_objectives .. caption .. "\n"
        --                 end

        --                 win_objectives = win_objectives .. color_prefix(r, g, b) .. objective_bullet .. description .. turn_counter .. "</span>" .. "\n"
        --             elseif condition == "lose" then
        --                 local caption = obj.caption
        --                 local r = obj.red or 255
        --                 local g = obj.green or 0
        --                 local b = obj.blue or 0

        --                 if caption then
        --                     lose_objectives = lose_objectives .. caption .. "\n"
        --                 end

        --                 lose_objectives = lose_objectives .. color_prefix(r, g, b) .. objective_bullet .. description .. turn_counter .. "</span>" .. "\n"
        --             else
        --                 wesmere.message "Unknown condition, ignoring."
        --             end
        --         end
        --     end

        --     for obj in helper.child_range(cfg, "gold_carryover") do
        --         local gold_carryover_bullet = obj.bullet or bullet
        --         local r = obj.red or 255
        --         local g = obj.green or 255
        --         local b = obj.blue or 192

        --         if obj.bonus ~= nil then
        --             if obj.bonus then
        --                 gold_carryover = color_prefix(r, g, b) .. gold_carryover_bullet .. "<small>" .. _"Early finish bonus." .. "</small></span>\n"
        --             else
        --                 gold_carryover = color_prefix(r, g, b) .. gold_carryover_bullet .. "<small>" .. _"No early finish bonus." .. "</small></span>\n"
        --             end
        --         end

        --         if obj.carryover_percentage then
        --             local carryover_amount_string = ""

        --             if obj.carryover_percentage == 0 then
        --                 carryover_amount_string = _"No gold carried over to the next scenario."
        --             else
        --                 carryover_amount_string = string.format(tostring(_ "%d%% of gold carried over to the next scenario."), obj.carryover_percentage)
        --             end

        --             gold_carryover = gold_carryover .. color_prefix(r, g, b) .. gold_carryover_bullet .. "<small>" .. carryover_amount_string .. "</small></span>\n"
        --         end
        --     end

        --     for note in helper.child_range(cfg, "note") do
        --         local show_if = helper.get_child(note, "show_if")
        --         if not show_if or wesmere.eval_conditional(show_if) then
        --             local note_bullet = note.bullet or bullet
        --             local r = note.red or 255
        --             local g = note.green or 255
        --             local b = note.blue or 255

        --             if note.description then
        --                 notes = notes .. color_prefix(r, g, b) .. note_bullet .. "<small>" .. note.description .. "</small></span>\n"
        --             end
        --         end
        --     end

        --     local summary = cfg.summary
        --     if summary then
        --         objectives = "<big>" .. insert_before_nl(summary, "</big>") .. "\n"
        --     end
        --     if win_objectives ~= "" then
        --         objectives = objectives .. "<big>" .. win_string .. "</big>\n" .. win_objectives
        --     end
        --     if lose_objectives ~= "" then
        --         objectives = objectives .. "\n" .. "<big>" .. lose_string .. "</big>\n" .. lose_objectives
        --     end
        --     if gold_carryover ~= "" then
        --         objectives = objectives .. "\n" .. gold_carryover_string .. "\n" .. gold_carryover
        --     end
        --     if notes ~= "" then
        --         objectives = objectives .. "\n" .. notes_string .. "\n" .. notes
        --     end
        --     local note = cfg.note
        --     if note then
        --         objectives = objectives .. "\n" .. note
        --     end

        --     return string.sub(tostring(objectives), 1, -2)
        -- end

        -- local function remove_ssf_info_from(cfg)
        --     cfg.side = nil
        --     cfg.side_name = nil
        --     for i, v in ipairs(cfg) do
        --         if v[1] == "has_unit" or v[1] == "enemy_of" or v[1] == "allied_with" then
        --             table.remove(cfg, i)
        --         end
        --     end
        -- end

    scheme:
        side: "Default '0'. The side to set the objectives for. A value of 0 sets objectives for all sides. note: There are side-specific objectives and default objectives, which are used in case a side doesn't have specific ones. Specifying 0 sets the default ones."
        -- StandardSideFilter tags and keys: Sets the objectives of all matching sides to these passed specifications (the rest of this [objectives] tag). If no sides (such as when passing side=0) or all sides match, sets the default objectives, and the side specific ones for the matching sides otherwise.
        bullet: "Default '• '. Replaces the default bullet, with whatever is passed, for all objectives, gold carryover notes, and notes defined with [note]."
        -- summary: Displayed first in the objectives text, this should describe the basic objective for the overall scenario. Can be omitted.
        -- note: Displayed last in the objectives text, this is sometimes used for hints or additional information. Can be omitted.
        victory_string:
            description: "this text precedes the victory objectives."
            default:  ' _ "Victory:"'
            type: "tstring"
        defeat_string:
            description: "this text precedes the defeat objectives."
            default: ' _ "Defeat:"'
            type: "tstring"
        gold_carryover_string:
            description: "this text precedes the gold carryover information."
            default: ' _ "Gold carryover:"'
            type: "tstring"
        notes_string:
            description: "this text precedes the notes."
            default: ' _ "Notes:"'
            type: "tstring"
        silent:
            description: "If set to 'true', the objectives are silently changed. Else, they will be shown to the user when appropriate."
            type: "bool"
            default: false

        objective:
            description: "describes a win or loss condition. Most scenarios have multiple win or loss conditions, so use a separate [objective] subtag for each line; this helps with translations."
            type: "table"
            scheme:
                bullet: "Default '• ' or whatever is set in the parent [objectives] block. Replaces the default bullet, with whatever is provided, for the objective defined by the [objective] block."
                red: "Default '0' for winning objectives, '255' for losing objectives. Overrides the default red coloring of the entire objective, including the bullet."
                green: "Default '255' for winning objectives, '0' for losing objectives. Overrides the default green coloring of the entire objective, including the bullet."
                blue: "Default '0'. Overrides the default blue coloring of the entire objective, including the bullet."
                description:
                    description: "text for the specific win or loss condition."
                condition:
                    description: "The color and placement of the text. Values are 'win'(colored green, placed after victory_string) and 'lose'(colored red, placed after defeat_string)"
                show_turn_counter:
                    description: "If set to yes, displays the number of turns remaining in the scenario. Default is no."

        show_if:
            description: "A condition that disables the objective if it doesn't hold. Conditional objectives are refreshed at [show_objectives] time only."

        gold_carryover:
            description: "describes how the gold carryover works in this scenario. This is intended to be a more convenient way of displaying carryover information than using the note= key in [objectives]."
-- bullet: Default '• ' or whatever is set in the parent [objectives] block. Replaces the default bullet with whatever is provided.
-- red: Default '255'. Overrides the default red coloring of the entire objective, including the bullet.
-- green: Default '255'. Overrides the default green coloring of the entire objective, including the bullet.
-- blue: Default '192'. Overrides the default blue coloring of the entire objective, including the bullet.
-- bonus (boolean): whether an early finish bonus is granted. If omitted, early finish bonus is not mentioned.
-- carryover_percentage: the amount of carryover gold. If omitted, the amount is not mentioned.
-- [note]: describes a note, usually used for hints or additional information. This is an easier way of adding several notes than concatenating them together into a single string to use with the note= key.
-- bullet: Default '• ' or whatever is set in the parent [objectives] block. Replaces the default bullet with whatever is provided for the note defined by the [note] block.
-- red: Default '255'. Overrides the default red coloring of the entire note, including the bullet.
-- green: Default '255'. Overrides the default green coloring of the entire note, including the bullet.
-- blue: Default '255'. Overrides the default blue coloring of the entire note, including the bullet.
-- description: the text of the note.
-- [show_if]: The note will not be shown if the specified condition isn't met. Conditional notes are refreshed at [show_objectives] time only.

