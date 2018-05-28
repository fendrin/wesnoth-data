wsl_action
    id: "scroll"
    description: "Scroll a certain number of pixels in a given direction. Useful for earthquake/shaking effects."

    action: ->
        error "'scroll' Not implemented yet."

    scheme:
        x: "the number of pixels to scroll along the x and y axis"
        y: "the number of pixels to scroll along the x and y axis"
        side: "the side or sides for which this should happen. By default, the [scroll] happens for everyone."
        filter_side:
            description: "a StandardSideFilter to select the sides for which this should happen. By default, the [scroll] happens for everyone."
