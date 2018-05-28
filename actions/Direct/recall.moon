wsl_action
    id: "recall"
    description: [[Recalls a unit taking into account any filter_recall of the leader. The unit is recalled free of charge, and is placed near its leader, e.g., if multiple leaders are present, near the first found which would be able to normally recall it.
If neither a valid map location is provided nor a leader on the map would be able to recall it, the tag is ignored.]]

    action: ->
        error "'recall' Not implemented yet."

    scheme:
        filter:
            description: [[the first matching unit will be recalled. If no units match this tag is ignored. If a comma separated list is given, every unit currently considered for recall is checked against all the types (not each single one of the types against all units).]]
            type: {"table", "function"}
            table: "SUF"
        x:
            description: "the unit is placed here instead of next to the leader."
            type: "number"
        y:
            type: "number"
        show:
            description: "whether the unit is animated (faded in) or instantly displayed"
            default: true
            type: "bool"
        fire_event:
            description: "whether any according prerecall or recall events shall be fired."
            type: "bool"
            default: false
        check_passability:
            description: "If true, checks for terrain passability when placing the unit (a nearby passable hex is chosen)."
            type: "bool"
            default: true
