
wsl_action
    id: "place_shroud"
    description: "Places some shroud on the map for a certain side (only relevant for sides that have shroud=yes)."

    action: ->
        error "'place_shroud' Not implemented yet."

    scheme:
        side:
            description: "(default=1) the side for which to place shroud. This can be a comma-separated list. note: Default side=1 for empty side= is deprecated."
            default: 1
            type: "number"

        filter_side:
            description: "with a StandardSideFilter as argument"

        StandardLocationFilter:
            description: "the range of tiles on which shroud should be placed"
