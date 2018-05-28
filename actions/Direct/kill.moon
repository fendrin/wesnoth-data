
wsl_action
    id: "kill"
    description: "Removes all units (including units in a recall list) that match the filter from the game."

    action: (cfg) ->
        wesmere.erase_unit(cfg)

    scheme:
        filter:
            description: "Selection criterion."
            type: "table"
            table: "StandardUnitFilter"
        animate:
            description: "if 'true', displays the unit dying (fading away)."
            type: "bool"
            default: "false"
        fire_event:
            description: "if 'true', triggers any appropriate 'die' events (See EventWSL). Note that events are only fired for killed units that have been on the map (as opposed to recall list)."
            type: "bool"
            default: "false"
        secondary_unit:
            description: "Has an effect only if fire_event: true. The first on-map unit matching the filter becomes second_unit in any fired die and last breath events. If an on-map unit matches and if there are several units killed with a single 'kill' table, second_unit is this same unit for all of them. If no on-map unit matches or 'secondary_unit' isn't present, the variable second_unit in each of the die and last breath events is always the same as the variable unit (the dying unit)."
            type: "table"
            table: "StandardUnitFilter"
