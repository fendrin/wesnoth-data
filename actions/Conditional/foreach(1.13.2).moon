

-- function wsl_actions.foreach(cfg)
--     local array_name = cfg.variable or helper.wsl_error "[foreach] missing required variable= attribute"
--     local array = helper.get_variable_array(array_name)
--     if #array == 0 then return end -- empty and scalars unwanted
--     local item_name = cfg.item_var or "this_item"
--     local this_item = utils.start_var_scope(item_name) -- if this_item is already set
--     local i_name = cfg.index_var or "i"
--     local i = utils.start_var_scope(i_name) -- if i is already set
--     local array_length = wesmere.get_variable(array_name .. ".length")

--     for index, value in ipairs(array) do
--         -- Some protection against external modification
--         -- It's not perfect, though - it'd be nice if *any* change could be detected
--         if array_length ~= wesmere.get_variable(array_name .. ".length") then
--             helper.wsl_error("WSL array length changed during [foreach] iteration")
--         end
--         wesmere.set_variable(item_name, value)
--         -- set index variable
--         wesmere.set_variable(i_name, index-1) -- here -1, because of WSL array
--         -- perform actions
--         for do_child in helper.child_range(cfg, "do") do
--             local action = utils.handle_event_commands(do_child, "loop")
--             if action == "break" then
--                 utils.set_exiting("none")
--                 goto exit
--             elseif action == "continue" then
--                 utils.set_exiting("none")
--                 break
--             elseif action ~= "none" then
--                 goto exit
--             end
--         end
--         -- set back the content, in case the author made some modifications
--         if not cfg.readonly then
--             array[index] = wesmere.get_variable(item_name)
--         end
--     end
--     ::exit::

--     -- house cleaning
--     utils.end_var_scope(item_name)
--     utils.end_var_scope(i)

--     --[[
--         This forces the readonly key to be taken literally.

--         If readonly=yes, then this line guarantees that the array
--         is unchanged after the [foreach] loop ends.

--         If readonly=no, then this line updates the array with any
--         changes the user has applied through the $this_item
--         variable (or whatever variable was given in item_var).

--         Note that altering the array via indexing (with the index_var)
--         is not supported; any such changes will be reverted by this line.
--     ]]
--     helper.set_variable_array(array_name, array)
-- end
