
-- wsl_actions["if"] = function(cfg)
--     if not (helper.get_child(cfg, 'then') or helper.get_child(cfg, 'elseif') or helper.get_child(cfg, 'else')) then
--         helper.wsl_error("[if] didn't find any [then], [elseif], or [else] children.")
--     end

--     if wesmere.eval_conditional(cfg) then -- evaluate [if] tag
--         for then_child in helper.child_range(cfg, "then") do
--             local action = utils.handle_event_commands(then_child, "conditional")
--             if action ~= "none" then break end
--         end
--         return -- stop after executing [then] tags
--     end

--     for elseif_child in helper.child_range(cfg, "elseif") do
--         if wesmere.eval_conditional(elseif_child) then -- we'll evaluate the [elseif] tags one by one
--             for then_tag in helper.child_range(elseif_child, "then") do
--                 local action = utils.handle_event_commands(then_tag, "conditional")
--                 if action ~= "none" then break end
--             end
--             return -- stop on first matched condition
--         end
--     end

--     -- no matched condition, try the [else] tags
--     for else_child in helper.child_range(cfg, "else") do
--         local action = utils.handle_event_commands(else_child, "conditional")
--         if action ~= "none" then break end
--     end
-- end
