wsl_action
    id: "delay"
    description: "Pauses the game."

    scheme:
        time:
            description: "the time to pause in milliseconds"
            accelerate: "(boolean yes|no, default no): (Version 1.13.0 and later only) whether the delay is affected by acceleration."

    action: (cfg, wesmere) ->
        delay = tonumber(cfg.time) or
            helper.wsl_error "[delay] missing required time= attribute."
        accelerate = cfg.accelerate or false
        wesmere.delay(delay, accelerate)
