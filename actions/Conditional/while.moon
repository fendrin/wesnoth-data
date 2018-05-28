


-- wsl_actions["while"] = function( cfg )
--     -- execute [do] up to 65536 times
--     for i = 1, 65536 do
--         if wesmere.eval_conditional( cfg ) then
--             for do_child in helper.child_range( cfg, "do" ) do
--                 local action = utils.handle_event_commands(do_child, "loop")
--                 if action == "break" then
--                     utils.set_exiting("none")
--                     return
--                 elseif action == "continue" then
--                     utils.set_exiting("none")
--                     break
--                 elseif action ~= "none" then
--                     return
--                 end
--             end
--         else return end
--     end
-- end
