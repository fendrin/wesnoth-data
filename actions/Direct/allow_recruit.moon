wsl_action
    id: "allow_recruit"
    description: [[Allows a side to recruit units it couldn't previously recruit.]]

    scheme:
        type:
            description: [[the types of units that the side can now recruit.]]
            mandatory: true
            list: true
        filter_side:
            description: [[(default=1) the number of the side that is being allowed to recruit the units. This can be a comma-separated list note: Default side=1 for empty side= is deprecated.
StandardSideFilter tags and keys; default for empty side= is all sides, as usual in a SSF.]]


    action: (cfg, wesmere) ->

        unit_types = cfg.type

        for side in *wesmere.get_sides(cfg.filter_side)
            v = side.recruit
            for type in unit_types
                table.insert(v, type)
                wesmere.add_known_unit(type)

		side.recruit = v

    --test: ->
    --    describe "allow_recruit test", ->

