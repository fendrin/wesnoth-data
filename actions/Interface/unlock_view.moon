wsl_action
    id: "unlock_view"
    description: "Unlocks gamemap view scrolling for human players."

    action: (cfg, wesmere) ->
        wesmere.lock_view(false)
