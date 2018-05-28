wsl_action
    id: "move_units_fake"
    description: "moves multiple images of units along paths on the map. These units are moved in lockstep."

    action: ->
        error "'move_units_fake' Not implemented yet."

    scheme:
        fake_unit:
            description: "A fake unit to move"
            scheme:
                type:
                    description: "the type of unit whose image to use"
                x:
                    description: "a comma-separated list of x locations to move along"
                y:
                    description: "a comma-separated list of y locations to move along (x and y values are matched pairs)"
                side:
                    description: "the side of the fake unit, used for team-coloring the fake unit"
                skip_steps:
                    description: "the number of steps to skip before this unit starts moving"
