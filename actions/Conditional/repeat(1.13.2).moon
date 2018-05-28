

-- wsl_actions["repeat"] = function(cfg)
--     local times = cfg.times or 1
--     for i = 1, times do
--         for do_child in helper.child_range( cfg, "do" ) do
--             local action = utils.handle_event_commands(do_child, "loop")
--             if action == "break" then
--                 utils.set_exiting("none")
--                 return
--             elseif action == "continue" then
--                 utils.set_exiting("none")
--                 break
--             elseif action ~= "none" then
--                 return
--             end
--         end
--     end
-- end

