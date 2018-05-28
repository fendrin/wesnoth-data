
wsl_action
    id: "insert_tag"
    description: [[Inserts a variable as WSL. In other words, the value of the passed container variable will be injected into the game as if they had been written out in WSL form. (See Example).
Tag insertion is a special case in that it can be used in places where other ActionWSL cannot be used. The basic rule is that anywhere that $variable syntax works, tag insertion will also work. In practice this means pretty much everywhere except directly within top-level scenario tags.]]

    action: (cfg) ->
        print "'insert_tag' not implemented yet."

    scheme:
        name:
            description: [[The ["name"] to be given to the tag. This must be a tag which would be valid at the place where [insert_tag] is used, for anything to happen. (For example, if used as ActionWSL, it should be a ActionWSL tag name, and it may be a recognized subtag such as "option" when used within a [message]).]]
        variable:
            description: "Name of the container variable which will have its value inserted into the tag."
