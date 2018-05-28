
wsl_action
    id: "tunnel"
    description: "Create a tunnel between some locations, later usable by units to move from source hex to target hex (using the movement cost of unit on the target terrain) (source).
(Note: The tunnel tag can also be used inside the [teleport] ability, without remove= and id=)."

    action: (cfg, kernel) ->
        kernel\print("'tunnel' not implemented yet.")

    scheme:
        id:
            description: "identifier for the tunnel, to allow removing (optional)."
            mandatory: false

        remove:
            description: "(boolean) yes/no value. If yes, removes all defined tunnels with the same ID (then only id= is necessary). (default: no)"
            type: "bool"
            default: false

        bidirectional:
            description: "(boolean) if yes, creates also a tunnel in the other direction. (default: yes)"
            type: "bool"


        always_visible:
            description: "(boolean) if yes, the possible movement of enemies under fog can be seen. (default: no)"
            type: "bool"
            default: false

        source:
            description: "StandardLocationFilter the source hex(es) (required)."
            mandatory: true
            type: "table"
            table: "SLF"

        target:
            description: "StandardLocationFilter the target hex(es) (required)."
            mandatory: true
            type: "table"
            table: "SLF"

        filter:
            description: [[StandardUnitFilter the units which can use the tunnel (required). Leave empty for "all units".]]
            type: "table"
            table: "SUF"
