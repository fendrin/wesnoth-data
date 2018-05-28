wsl_action
    id: "do_command"
    description: [[Executes a command, specified using the same syntax as a [command] tag in ReplayWSL. Not all [command]'s are valid: only these are accepted
[attack]
[move]
[recruit]
[recall]
[disband]
[fire_event]
[lua_ai]
The tags corresponding to player actions generally use the same codepath as if a player had ordered it.
One purpose of this tag is to allow scripting of noninteractive scenarios -- without a tag like this, this might require elaborate mechanisms to coerce ais in order to test these code paths.
This command should always be replay safe.]]

    action: (func) ->
        wesmere.execute_command(func)
