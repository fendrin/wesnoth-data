wsl_action
    id: "put_to_recall_list"
    description: [[(Version 1.13.0 and later only)
Puts a unit to the recall list of its side.]]

    action: (cfg, kernel) ->
        units = wesmere.get_units(cfg)
        for unit in *units
            if cfg.heal
                with unit
                    .hitpoints = unit.max_hitpoints
                    .moves = unit.max_moves
                    .attacks_left = unit.max_attacks
                    .status.poisoned = false
                    .status.slowed = false
            wesmere.put_recall_unit(unit, unit.side)
            wesmere.erase_unit(unit)

    scheme:
        StandardUnitFilter:
            description: [[the unit(s) to get put to the recall list.]]
            type: "Table"
            table: "SUF"

        heal:
            description: [[(default=no) Whether the unit should be refreshed, similar to the unit moving to the recall list at the end of a scenario.]]
            default: false
            type: "Bool"
