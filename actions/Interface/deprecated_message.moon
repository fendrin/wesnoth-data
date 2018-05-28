wsl_action
    id: "deprecated_message"
    description: "Shows a deprecated message in the message area, this feature is only intended to be used to warn about deprecated macros in mainline. The message is not translatable."

    action: ->
        error "'deprecated_message' Not implemented yet."

    scheme:
        message:
            description: "the message to show."
