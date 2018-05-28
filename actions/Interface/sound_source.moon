

wsl_action

    id: "sound_source"

    description: [[Creates a sound source. "Sound sources" is a general name for a mechanism which makes possible for map elements to emit sounds according to some rules, where "map elements" can be specific locations or terrain types. For now, only sound sources tied to locations are supported.]]

    action: ->
        error "'sound_source' Not implemented yet."

    scheme:

        id:
            description: [[a unique identification key of the sound source]]

        sounds:
            description: [[a list of comma separated, randomly played sounds associated with the sound source]]

        delay: [[a numerical value (in milliseconds) of the minimal delay between two playbacks of the source's sound if the source remains visible on the screen; if one scrolls out and back in, the source will be considered as ready to play
chance: a percentage (a value from 0 to 100) describing the chance of the source being activated every second after the delay has passed or when the source's location appears on the screen (note that it cannot play more than one file at the same time)
        check_fogged: possible values "true" and "false" - if true the source will not play if its locations are fogged
        check_shrouded: possible values "true" and "false" - if true the source will not play if its locations are shrouded
        x,y: similar to x,y as found in a StandardLocationFilter, these are the locations associated with the sound source
fade_range (default = 3): distance in hexes that determines a "circular" area around the one specified by full_range where sound volume fades out linearly
full_range (default = 14): distance in hexes that determines a "circular" area where source plays with full volume, relative to screen center
        loop: number of times a sound sample should be looped if it stays visible. -1 means infinite (~65000)]]
