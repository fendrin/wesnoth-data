
wsl_action
    id: "replace_schedule"
    description: "Replace the time of day schedule of the entire scenario."

    action: (cfg) ->
        if schedule = cfg.schedule
            assert(#schedule > 0, "WSLAction replace_schedule with empty one")
            wesmere.set_schedule(schedule)

    scheme:
        schedule:
            --TimeWSL:
            description: "the new schedule."

        current_time:
            description: "The time slot number (starting with one) active at schedule replacement."

