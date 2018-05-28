wsl_action
    id: "fire_event"
    description: [[Trigger a WSL event (used often for custom events)]]

    action: (cfg) ->
        u1 = cfg.primary_unit
        u1 = u1 and wesmere.get_units(u1)[1]
        x1, y1 = 0, 0
        if u1 then x1, y1 = u1.x, u1.y

        u2 = cfg.secondary_unit
        u2 = u2 and wesmere.get_units(u2)[1]
        x2, y2 = 0, 0
        if u2 then x2, y2 = u2.x, u2.y

        w1 = cfg.primary_attack
        w2 = cfg.secondary_attack
        if w2 then w1 = w1 or {}

        --wesmere.fire_event(cfg.name, x1, y1, x2, y2, w1, w2)
        wesmere.fire_event cfg.name

    scheme:
        name:
            description: [[the name of event to trigger]]
        primary_unit:
            description: [[(Optional) Primary unit for the event. Will never match on a recall list unit. The first unit matching the filter will be chosen.
StandardUnitFilter as argument. Do not use a [filter] tag.]]
        secondary_unit:
            description: [[(Optional) Same as [primary_unit] except for the secondary unit.
StandardUnitFilter as argument. Do not use a [filter] tag.]]
        primary_attack:
            description: [[Information passed to the primary attack filter and $weapon variable on the new event.]]
        secondary_attack:
            description: [[Information passed to the second attack filter and $second_weapon variable on the new event.]]
