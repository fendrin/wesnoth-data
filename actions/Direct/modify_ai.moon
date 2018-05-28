
wsl_action
    id: "modify_ai"
    description: "Changes AI objects (aspects, goals, candidate actions or stages) for a specified side. See AiWSL for full description."

    action: ->
        error "'modify_ai' Not implemented yet."

    scheme:
        action:
            description: "(string): Takes values 'add', 'change', 'delete' or 'try_delete' to do just that for the AI object."

        path:
            description: "(string): Describes which AI object is to be modified."

        facet: {}
        goal: {}
        candidate_action: {}
        stage:
            description: "Details about the AI object to be modified."

        StandardSideFilter:
            description: "tags and keys; default for empty side= is all sides, as usual in a SSF."
