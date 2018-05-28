wsl_action
    id: "store_turns"
    description: "Stores the turn limit (the maximum number of turns). If there is no limit, this stores -1."

    action: (cfg) ->
        var = cfg.variable or "Turns"
        wesmere.set_variable(var, wesmere.get_turn_limit!)

    scheme:
        variable:
            description: "the name of the variable in which to store the turn limit."
            default: "turns"
            type: "string"
