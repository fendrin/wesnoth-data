
wsl_action
    id: "remove_shroud"
    description: "Removes some shroud from the map for a certain side (only relevant for sides that have shroud: true)."

    action: ->
        error "'remove_shroud' Not implemented yet."

    scheme:
        side:
            description: "(default=1) the side for which to remove shroud. This can be a comma-separated list of sides. note: Default side=1 for empty side= is deprecated."
            default: 1
            type: "number"

        filter_side:
            description: "with a StandardSideFilter as argument"
            type: "table"
            table: "SSF"

        StandardLocationFilter:
            description: "the range of tiles for which shroud should be removed"
            type: "table"
            table: "SLF"
