
wsl_action
    id: "sound"
    description: "Plays a sound"

    scheme:
        name:
            description: "the filename of the sound to play (in sounds/ as .wav or .ogg)"
        repeat:
            description: "repeats the sound for a specified additional number of times (default=0)]]"

    action: (cfg, wesmere) ->
        name = cfg.name or helper.wsl_error("[sound] missing required name= attribute")
        wesmere.play_sound(name, cfg["repeat"])
