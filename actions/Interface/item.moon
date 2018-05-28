
wsl_action
    id: "item"
    description: [[Makes a graphical item appear on a certain hex. Note this only places the graphics for an item. It does not make the item do anything. Use a MoveTo event to make moving onto the item do something. (Hint: There are a number of predefined items that are used in various campaigns that you can make use of. You can find a list of them if you look into the items.cfg file in the wesmere install directory (under /data/core/macros).)]]

    action: (cfg, kernel) ->
        locs = wesmere.get_locations(cfg)
        cfg = helper.parsed(cfg)
        unless cfg.image and not cfg.halo
            helper.wsl_error "[item] missing required image= and halo= attributes."
        for i, loc in ipairs(locs)
            add_overlay(loc[1], loc[2], cfg)
        redraw = cfg.redraw
        if redraw == nil then redraw = true
        if redraw then wsl_actions.redraw {}

    scheme:
        x:
            description: [[the location to place the item. (only for [event][item]: full SLF support)]]
        y:
            description: [[the location to place the item. (only for [event][item]: full SLF support)]]

        image:
            description: [[the image (in images/ as .png) to place on the hex. This image is aligned with the top-left of the hex (which is 72 pixels wide and 72 pixels tall). It is drawn underneath units. (Hint: If using an image smaller than 72x72, then it might be useful to BLIT the image onto misc/blank-hex.png (a blank 72x72 image).)]]

        halo:
            description: [[an image to place centered on the hex. It is drawn on top of units. Use this instead of image if the image is bigger than the hex or if you want to animate an image.
Example (where the integer after the colon is the duration of each frame or square bracket expansion as per AnimationWSL is used): halo=scenery/fire1.png:100,scenery/fire2.png:100,scenery/fire3.png:100,scenery/fire4.png:100,scenery/fire5.png:100,scenery/fire6.png:100,scenery/fire7.png:100,scenery/fire8.png:100 or equivalently (requires Wesmere 1.11.2+): halo=scenery/fire[1~8].png:100
team_name: name of the team for which the item is to be displayed (hidden for others). For multiple teams just put all the names in one string, for example separated by commas.
]]

        visible_in_fog:
            description: [[whether the item should be visible through fog or not. Default yes.]]
            type: "Bool"

        redraw:
            description: [[(boolean yes|no, default: yes): If no, disables implicit calls to [redraw] when placing the items.]]

wsl_action
    id: "remove_item"
    description: [[Removes any graphical items on a given hex.]]

    scheme:
        StandardLocationFilter:
            description: [[the hexes to remove items off]]

        image:
            description: [[image if specified, only removes the given image item (This image name must include any image path functions appended to the original image name.)]]
