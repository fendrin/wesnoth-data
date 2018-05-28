wsl_action
    id: "test_condition"

    description: "Evaluates the contained conditional tags. If they evaluate to the expected value, it prints out a message to the console explaining which part of the condition caused this result in a way similar to [wsl_message]. This can be used if your conditional test is failing and you're not sure why."

    scheme:
        result: "Whether you expect the conditions to fail or succeed. If no (the default), a message will be printed if the conditional tags fail. If yes, a message will instead be printed if the conditional tags pass."
        logger: [[Same as for [wsl_message]. Defaults to "warning".]]

-- This is mainly for use in unit test macros, but maybe it can be useful elsewhere too
    action: (cfg, wesmere) ->
        logger = cfg.logger or "warning"

        -- This function returns true if it managed to explain the failure
        explain = (current_cfg, expect) ->
            for i,t in ipairs(current_cfg)
                tag, this_cfg = t[1], t[2]
                -- Some special cases
                if tag == "or" or tag == "and"
                    if explain(this_cfg, expect)
                        return true

                elseif tag == "not"
                    if explain(this_cfg, not expect)
                        return true

                elseif tag == "true" or tag == "false"
                    -- We don't explain these ones.
                    return true
                elseif wesmere.eval_conditional{t} == expect
                    explanation = "The following conditional test %s:"
                    if expect
                        explanation = explanation:format("passed")
                    else
                        explanation = explanation:format("failed")

                    explanation = string.format("%s\n\t[%s]", explanation, tag)
                    for k,v in pairs(this_cfg)
                        if type(k) ~= "number"
                            format = "%s\n\t\t%s=%s"
                            literal = tostring(helper.literal(this_cfg)[k])
                            if literal ~= v then
                                format = format .. "=%s"

                            explanation = string.format(format, explanation, k, literal, tostring(v))


                    explanation = string.format("%s\n\t[/%s]", explanation, tag)
                    if tag == "variable" then
                        explanation = string.format("%s\n\tNote: The variable %s currently has the value %q.", explanation, this_cfg.name, tostring(wesmere.get_variable(this_cfg.name)))

                    wesmere.wsl_actions.wsl_message{message: explanation, logger: logger}
                    return true

        -- Use not twice here to convert nil to false
        explain(cfg, not not cfg.result)
