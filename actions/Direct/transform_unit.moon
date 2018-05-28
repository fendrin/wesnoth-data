wsl_action
    id: "transform_unit"
    description: [[Transforms every unit matching the filter to the given unit type. Keeps intact hit points, experience and status. If the unit is transformed to a non-living type (undead or mechanical), it will be also unpoisoned. Hit points will be changed if necessary to respect the transformed unit's maximum hit points.]]

    action: (cfg, kernel) ->

        transform_to = cfg.transform_to

        for unit in *wesmere.get_units(cfg)

            if transform_to
                wesmere.transform_unit( unit, transform_to )
            else
                hitpoints = unit.hitpoints
                experience = unit.experience
                recall_cost = unit.recall_cost
                status = helper.get_child( unit.__cfg, "status" )

                unit.experience = unit.max_experience
                wsl_actions.advance_unit(unit, false, false)

                unit.hitpoints = hitpoints
                unit.experience = experience
                recall_cost = unit.recall_cost

                for key, value in pairs(status) do unit.status[key] = value
                if unit.status.unpoisonable then unit.status.poisoned = nil

        wsl_actions.redraw {}

    scheme:
        filter:
            description: [[do use a [filter] table.]]
            type: "SUF"
        transform_to:
            description: [[the unit type's id in which all the units matching the filter will be transformed. If missing, the units will follow their normal advancement.]]
            type: "unit_type_id"


