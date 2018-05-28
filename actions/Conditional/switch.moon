

-- function wsl_actions.switch(cfg)
--     local var_value = wesmere.get_variable(cfg.variable)
--     local found = false

--     -- Execute all the [case]s where the value matches.
--     for v in helper.child_range(cfg, "case") do
--         for w in utils.split(v.value) do
--             if w == tostring(var_value) then
--                 local action = utils.handle_event_commands(v, "switch")
--                 found = true
--                 if action ~= "none" then goto exit end
--                 break
--             end
--         end
--     end
--     ::exit::

--     -- Otherwise execute [else] statements.
--     if not found then
--         for v in helper.child_range(cfg, "else") do
--             local action = utils.handle_event_commands(v, "switch")
--             if action ~= "none" then break end
--         end
--     end
-- end

