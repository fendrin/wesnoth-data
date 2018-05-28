wsl_action
    id: "inspect"
    description: "This user interface instantly displays the gamestate inspector dialog at the current scenario state (the same one that can be brought up with the :inspect command), which can be used to inspect the values of WSL variables, AI configuration, recall lists, and more."

    action: ->
        error "'inspect' Not implemented yet."

    scheme:
        name: "optional attribute to specify the name of this gamestate inspector dialog. It is just a label to help differentiate between different invocations of gamestate inspector dialog."
