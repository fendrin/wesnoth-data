wsl_action
    id: "remove_time_area"

    action: (cfg) ->
        id = cfg.id or error("remove_time_area() missing required 'id' key")
        for w in *id
            wesmere.remove_time_area(w)
