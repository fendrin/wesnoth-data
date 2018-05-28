
wsl_action
    id: "petrify"
    description: [[StandardUnitFilter as an argument. Do not use a [filter] tag. All units matching this filter are petrified. Recall list units are included.]]

    action: (cfg, kernel) ->
        for unit in *wesmere.get_units(cfg)
            unit.status.petrified = true
            -- Extract unit and put it back to update animation (not needed for recall units)
            wesmere.extract_unit(unit)
            wesmere.put_unit(unit)
        for unit in *wesmere.get_recall_units(cfg)
            unit.status.petrified = true

    scheme:
        StandardUnitFilter:
            description: "as an argument. Do not use a [filter] tag. All units matching this filter are petrified. Recall list units are included."
