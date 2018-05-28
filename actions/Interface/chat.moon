wsl_action
    id: "chat"
    description: "Displays a message in the chat area, not visible for observers. Alternative visible for observers: LuaWSL:Display#wesmere.message"

    scheme:
        speaker:
            description: [[(default="WSL") A string for the name of the sender of the message.]]

        message:
            description: "The message that should be displayed."
            StandardSideFilter:
                description: "tags and keys as argument; if the same client controls multiple sides that match, then the message will only be displayed once."

    action: (cfg, wesmere) ->
        side_list = wesmere.get_sides(cfg)
        speaker = tostring(cfg.speaker or "WSL")
        message = tostring(cfg.message or
            helper.wsl_error "[chat] missing required message= attribute.")

        for side in *side_list
            if side.controller == "human"
                wesmere.message(speaker, message)
                break
