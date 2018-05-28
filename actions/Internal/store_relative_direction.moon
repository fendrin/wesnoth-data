wsl_action
    id: "store_relative_direction"
    description: [[(Version 1.13.0 and later only)
Gets the relative direction from one hex to another. This is an interface to the function wesmere uses to decide how a unit will face while it is moving / attacking / defending.]]

    action: (cfg, kernel) ->

    scheme:
        source: "x and y must describe a map location"
        destination: "similar"
        variable: "name of the variable to store string result in (one of 'n', 'nw', 'ne', 's', 'sw', 'se')"
        mode:
            description: [[optional. 0 is the default setting corresponding to default wesmere implementation used in animations. 1 is an alternate "radially symmetric" mode. The default mode breaks ties in the direction of south, since this makes more units face the player directly on screen. The radially symmetric mode breaks ties in the direction of counter-clockwise, and might be more appropriate in some cases.]]
