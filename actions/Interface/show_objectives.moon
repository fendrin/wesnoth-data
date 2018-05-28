wsl_action
    id: "show_objectives"
    description: [[refreshes the objectives defined by [objectives] and its [show_if] tags, and displays them. (It is also called whenever the user explicitly asks for the objectives; this matters only if the tag was overridden by a Lua script.)]]

    action: (cfg, wesmere) ->
        cfg0 = scenario_objectives[0]
        local_show_objectives = (sides) ->
            objectives0 = cfg0 and generate_objectives(cfg0)
            for side in *sides
                cfg = scenario_objectives[side.side]
                objectives = (cfg and generate_objectives(cfg)) or objectives0
                if objectives then side.objectives = objectives
                side.objectives_changed = true

        sides = wesmere.get_sides(cfg)
        if #sides == 0
            local_show_objectives(wesmere.sides)
        else
            local_show_objectives(sides)

    scheme:
        side:
            description: "the side to show the objectives. If not set, all sides are used."
            type: "number"

-- StandardSideFilter tags and keys: Tag affects the matching sides instead of just all or the one given by the integer value of the side= key.]]
