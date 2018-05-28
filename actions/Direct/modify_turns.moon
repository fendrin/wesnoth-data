
wsl_action
    id: "modify_turns"
    description: "Modifies the turn limit in the middle of a scenario."

    action: (cfg) ->
        if value = cfg.value
            wesmere.set_turn_limit(value)
        if add = cfg.add
            old_limit = wesmere.get_turn_limit!
            wesmere.set_turn_limit(old_limit + add)
        if current = cfg.current
            assert(1 <= current, "WSL_Action 'modify_turns': Can't set a negative current turn.'")
            limit = wesmere.get_turn_limit!
            if limit >= 0
                assert(current <= wesmere.get_turn_limit!, "WSL_Action 'modify_turns': Can't set the current turn beyond the turn limit.'")
            wesmere.set_turn(current)

    scheme:
        value:
            description: "the new turn limit."
        add:
            description: "if used instead of value, specifies the number of turns to add to the current limit (can be negative)."
        current:
            description: "changes the current turn number after applying turn limit modifications, if any. It is not possible to change the turn number to exceed the turn limit (1 <= current turns <= max turns)."
