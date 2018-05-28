
wsl_action
    id: "time_area"
    description: "How a day should progress in a given area. Everywhere not specified in a [time_area] table is affected by the [time] tables in the [scenario] table."
    usage: [[Example: (caves in parts of a map)
time_area:
    x: {"1-2", "4-5"}
    y: {"1-2", "1-2"}
    time: UNDERGROUND]]

    action: (cfg) ->
        assert(cfg)
        if cfg.remove
            wesmere.wsl_actions.remove_time_area(cfg)
        else
            wesmere.add_time_area(cfg)

    scheme:
        filter_location:
            description: [[StandardLocationFilter: the locations to affect. note: only for [event][time_area]s - at scenario toplevel [time_area] does not support StandardLocationFilter, only location ranges]]
            type: "SLF"

        time:
            description: [[the new schedule.]]
            type: "TimeWSL"
            is_list: true

        id:
            description: [[an unique identifier assigned to a time_area. Optional, unless you want to remove the time_area later. Can be a comma-separated list when removing time_areas, see below.]]
            type: "String"
            is_list: true

        remove:
            description: [[(boolean) yes/no value. Indicates whether the specified time_area should be removed. Requires an identifier. If no identifier is used, however, all time_areas are removed.]]
            type: "Bool"

        current_time:
            description: [[The time slot number (starting with zero) active at the creation of the area.]]
            type: "Signed"
