wsl_action
    id: "modify_unit"

    description: [[works similar to the MODIFY_UNIT function.
Accepts generally the syntax inside of wsl unit variables created by [store_unit] which can be viewed in a savefile or by using the :inspect command. It can add [trait]s and [object]s without needing to wrap them inside a [modifications] tag, and their effects are applied immediately. Cannot remove things. Subtags with the same name must be written in the correct order to match them with the tag they are supposed to modify.

example usage (see also the test scenario):
modify_unit
    filter:
        x: 38
        y: 6
    hitpoints: 10
    --- @todo TRAIT_HEALTHY
The unit which is currently modified is accessible via this_unit,
e.g. hitpoints: this_unit.hitpoints / 2
to set the hitpoints of all units to half of their particular maxima. This this_unit variable is independent from the this_unit variable available in the SUF used to determine which units to modify (first all matching units are gathered, and then all those are modified).
note: The syntax allowed is somehow vague. Just try things and possibly correct/add/modify this documentation. (a forum thread discusses some related issues).]]

    action: (cfg) ->

        -- wsl_actions = wesmere.wsl_actions

        -- wesmere.debug wsl_actions

        -- unit_variable = "LUA_modify_unit"

        -- handle_attributes = (cfg, unit_path, toplevel) ->
        --     for current_key, current_value in pairs(helper.shallow_parsed(cfg))
        --         if type(current_value) ~= "table" and (not toplevel or current_key ~= "type")
        --             wesmere.set_variable(string.format("%s.%s", unit_path, current_key), current_value)

        -- handle_child = (cfg, unit_path) ->
        --     children_handled = {}
        --     cfg = helper.shallow_parsed(cfg)
        --     handle_attributes(cfg, unit_path)

        --     for current_index, current_table in ipairs(cfg)
        --         current_tag = current_table[1]
        --         tag_index = children_handled[current_tag] or 0
        --         handle_child(current_table[2], string.format("%s.%s[%u]", unit_path, current_tag, tag_index))
        --         children_handled[current_tag] = tag_index + 1

        -- filter = cfg.filter
        -- handle_unit = (unit_num) ->
        --     children_handled = {}
        --     unit_path = string.format("%s[%u]", unit_variable, unit_num)
        --     this_unit = wesmere.get_variable(unit_path)
        --     wesmere.set_variable("this_unit", this_unit)
        --     handle_attributes(cfg, unit_path, true)

        --     for current_index, current_table in ipairs(helper.shallow_parsed(cfg))
        --         current_tag = current_table[1]
        --         if current_tag != "filter"
        --             -- nothing
        --             if current_tag == "object" or current_tag == "trait" or current_tag == "advancement"
        --                 unit = wesmere.get_variable(unit_path)
        --                 unit = wesmere.create_unit(unit)
        --                 wesmere.add_modification(unit, current_tag, current_table[2])
        --                 unit = unit.__cfg
        --                 wesmere.set_variable(unit_path, unit)
        --             else
        --                 tag_index = children_handled[current_tag] or 0
        --                 handle_child(current_table[2], string.format("%s.%s[%u]", unit_path, current_tag, tag_index))
        --                 children_handled[current_tag] = tag_index + 1

        --     if cfg.type
        --         if cfg.type ~= "" then wesmere.set_variable(unit_path .. ".advances_to", cfg.type)
        --         wesmere.set_variable(unit_path .. ".experience", wesmere.get_variable(unit_path .. ".max_experience"))

        --     wsl_actions.kill({ id: this_unit.id, animate: false })
        --     wsl_actions.unstore_unit { variable: unit_path }


        -- wsl_actions.store_unit { {"filter", filter}, variable: unit_variable }
        -- max_index = wesmere.get_variable(unit_variable .. ".length") - 1

        -- this_unit = utils.start_var_scope("this_unit")
        -- for current_unit = 0, max_index
        --     handle_unit(current_unit)

        -- utils.end_var_scope("this_unit", this_unit)

        -- wesmere.set_variable(unit_variable)


    scheme:
        filter:
            description: "with a StandardUnitFilter as argument. All units matching this filter are modified. Matches on recall list units too."
