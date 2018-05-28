color_description = "(default=0,0,0) the color to display the text in. Values vary from 0-255."

wsl_action
    id: "print"
    description: "Displays a message across the screen. The message will disappear after a certain time."

    action: (cfg, kernel) ->
        wesmere.print(cfg)

    scheme:
        text:
            description: "(translatable) the text to display."
            type: "tString"
            mandatory: true
        size:
            description: "(default=12) the pointsize of the font to use"
            type: "Signed"
            default: 12
        duration:
            description: "(default=50) the length of time to display the text for. This is measured in the number of 'frames'. A frame in Wesmere is usually displayed for around 30ms."
            type: "Signed"
            default: 50
        red:
            description: color_description
            type: "Signed"
            default: 0
        green:
            description: color_description
            type: "Signed"
            default: 0
        blue:
            description: color_description
            type: "Signed"
            default: 0
