wsl_action
    id: "wsl_message"
    description: "Outputs a message to Wesmere's console output. Intended for campaign designers to output silent text to the console, without annoying the player; then, that text might contain information useful for later bug-reporting. The log domain for it is wsl, and the debug/dbg log level is available for use with the logger attribute. Depending on the current log level (error by default), which may be changed with the in-game :log command, or the --log-<level>=wsl command line switch, the messages are echoed to the in-game chat."

    action: ->
        error "'wsl_message_source' Not implemented yet."


    scheme:
        message: "the message to show."
        logger: [[the Wesmere engine output logger that should catch the text; this might be 'err' (the errors log level), 'warn'/'wrn' (the warnings log level) or anything else (the information log level). Not all information will be displayed depending on the log level chosen when starting Wesmere.
Note: As of 1.9.4/1.9.5 (r48805) the following "loggers" should work: If in [wsl_message]: err/error, warn/wrn/warning, debug/dbg; using the :log command: Only the long forms error, warning, info and debug (this part gathered by trying rather than source inspecting). The long forms are most likely also the only ones working when starting wesmere with --log-<level>=wsl. For log level warning or error (as during normal play), only wsl_messages with logger error or warning display (for both). With logger info or debug, additionally wsl_messages with logger info or debug display (for both).]]
