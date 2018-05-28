
wsl_action
    id: "open_help"
    description: "Opens the in-game help."

    action: (cfg, kernel) ->
        kernel\send_request("help_browser", cfg.topic)

    scheme:
        topic:
            description: "the id of the topic to open"
            type: "String"
            mandatory: true
