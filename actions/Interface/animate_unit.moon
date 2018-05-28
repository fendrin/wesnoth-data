

wsl_action
    id: "animate_unit"

    description: "Uses an animation of a unit to animate it on screen (if the unit has the corresponding animation)."

    action: ->
        error "'animate_unit' Not implemented yet."


    scheme:

        flag:
            description: "The key to find the custom animation in the unit description (see the [extra_anim] description in AnimationWSL). Standard animations can be triggered with the following keywords: leading recruited standing idling levelout levelin healing healed poisoned movement defend attack death victory pre_teleport post_teleport"
        filter:
            description: "with a StandardUnitFilter as argument, see FilterWSL. By default, the unit at the event location will be animated. You can use this tag to choose any other unit to animate."

        primary_attack:
            description: "If this tag is not present, the filter for animation will be triggered with no attack. If it is here, all attacks from the unit will be filtered, and a matching one will be used to filter the animation. Takes a weapon filter as argument, see FilterWSL."

        secondary_attack:
            description: "Similar to [primary_attack]. May be needed to trigger a defense animation correctly, if there are more than one animations available for the defending unit."

        hits:
            description: "yes/no/hit/miss/kill: which according variation of a attack/defense animation shall be chosen (required)"
            type: "enum"
            enum: {"yes", "no", "hit", "miss", "kill"}

        text:
            description: "a text to hover during the animation"
        male_text:
        female_text:
            description: "(Version 1.13.2 and later only) (translatable) gender-specific versions of the above"
        red:
            description: "red value for the text color (0-255)"
        green:
            description: "green value for the text color"
        blue:
            description: "blue value for the text color"
        with_bars:
            description: "yes/no: whether to display the status bars during the animation (e.g. the hitpoint bar)"
        animate:
            description: "a sub block with the same syntax as [animate_unit] except that the [filter] block is mandatory to find the unit. This block will find and animate another unit simultaneously."
        facing:
            description: "a StandardLocationFilter specifying what direction the unit should be facing when animated"
