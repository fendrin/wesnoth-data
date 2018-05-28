
wsl_action
    id: "set_menu_item"
    description: [[This tag is used to add a custom option in the right-click context menu which can then be used to trigger arbitrary WSL commands. The menu items can be set and modified during any event, for example during "start" or "prestart" events. The user can also assign hotkeys to these WSL commands unless specified otherwise. When the hotkey is pressed the event will be fired/filtered at the current mouse position.]]

    action: (cfg, kernel) ->
        kernel\send_request("set_menu_item")

    scheme:
        id:
            description: "the unique id for this menu item. If a menu item with this id already exists, it allows you to set specific changes to that item."

        description:
            description: "the in-game text that will appear for this item in the menu."

        image:
            description: "the image to display next to this item."

        needs_select:
            description: [[if yes (default no), then the latest select event (see EventWSL) that triggered before this menu item was chosen will be transmitted over the network before this menu item action will be. This only has any effect in networked multiplayer, and is intended to allow more elaborate menu item behaviour there without causing out of sync errors. If you don't know what this means, just leave it false.]]

        use_hotkey:
            description: [[if no (default yes), then the user cannot assign hotkeys to this menu item. If only, the menu item is only accessible via hotkeys, not via right-click context; you can use this in combination with [default_hotkey] if you want custom hotkeys in your campaign/mp.]]

        show_if:
            description: [[If present, the menu item will only be available if the conditional statement (see ConditionalActionsWSL) within evaluates to true. When this is evaluated, the WSL variables $x1 and $y1 will point to the location on which the context menu was invoked, so it's possible to for example only enable the option on empty hexes or on a particular unit.]]

        filter_location:
            description: [[contains a location filter similar to the one found inside Single Unit Filters (see FilterWSL). The menu item will only be available on matching locations.]]

        default_hotkey:
            description: [[contains a hotkey WSL to specify what hotkey to assign to this, if the user has no hotkey assigned to this yet. (Unlike the rest of a menu item definition, modifying this tag has no effect on the game; it is only effective when initially defining a menu item.) Hotkey WSL matches the format in the preferences file and contains the following keys:
key: a string that contains the key to assign to this.
alt, shift, cmd(apple only), ctrl: boolean values.]]

        command:
            description: [[contains the WSL actions to be executed when the menu item is selected. Again, the WSL variables $x1 and $y1 will point to the location on which the context menu was invoked on.]]

        delayed_variable_substitution:
            description: [[(boolean yes|no, default: yes): If no, forces a variable substitution run onto the wsl included in this [command] block. Use this, if you want variables which are to substitute to get the values they have at execution time of the event where this set_menu_item appears. Other than that, they get the values they have at invocation time of the menu item.]]
