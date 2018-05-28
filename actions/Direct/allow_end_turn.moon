wsl_action
    id: "allow_end_turn"
    description: "Allows human players to end their turn through the user interface if they were previously affected by the [disallow_end_turn] action. This action doesn't take any arguments."

    action: (cfg, kernel) ->
        kernel\print("'allow_end_turn' not implemented yet.")

    scheme: {}
