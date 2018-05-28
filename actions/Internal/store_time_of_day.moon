wsl_action
    id: "store_time_of_day"
    description: "Stores time of day information from the current scenario into a WSL variable container.
Time areas matter; illumination does not. If this is omitted, the global (location-independent) time is stored."

    action: (cfg) ->
        turn = cfg.turn or wesmere.get_turn!
        assert(turn)
        illumination = cfg.illumination

        -- local time, loc
        -- try
        --     do: ->
        --         loc = Loc(cfg)
        --     catch: (err) ->
        --         time = wesmere.get_time_of_day(turn)
        --     finally: ->
        --         time = wesmere.get_time_of_day(turn, {loc.x, loc.y, illumination})

        time = wesmere.get_time_of_day(turn)
        assert(time, "WSLAction store_time_of_day: got nil for turn #{turn}")

        variable = cfg.variable or "time_of_day"
        wesmere.set_variable(variable, time)
        return time

    scheme:
        x:
            description: "Location to store the time for."
            type: "number"
        y:
            description: "Location to store the time for."
            type: "number"
        variable:
            description:"name of the container on which to store the information. The container will be filled with the same keys found on TimeWSL."
            default:"time_of_day"
            type: "string"
        turn:
            description: "(defaults to the current turn number) changes the turn number for which time of day information should be retrieved."
            type: "number"
        illumination:
            description: "consider illumination"
            default: false
            type: "bool"
