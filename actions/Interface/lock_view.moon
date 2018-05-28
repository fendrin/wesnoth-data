wsl_action
    id: "lock_view"
    description: "Locks gamemap view scrolling for human players, so they cannot scroll the gamemap view until it is unlocked. WSL or Lua actions such as [scroll_to] will continue to work normally, as they ignore this restriction; the locked/unlocked state is preserved when saving the current game.
This feature is generally intended to be used in cutscenes to prevent the player scrolling away from scripted actions."

    action: (cfg, wesmere) ->
        wesmere.lock_view(true)
