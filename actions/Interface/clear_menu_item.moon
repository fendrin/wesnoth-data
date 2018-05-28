wsl_action
    id: "clear_menu_item"
    description: "Removes a menu item from the scenario. Normally menu items are, including all their defining wsl, automatically carried over between scenarios. This tag prevents this. (The behavior is comparable to set_variable/clear_variable)."

    action: (cfg, wesmere) ->

    scheme:
        id:
            description: "(string): id of the menu item to clear. Can be a comma-separated list."
