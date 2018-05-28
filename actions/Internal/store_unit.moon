
wsl_action
    id: "store_unit"
    description: [[Stores details about units into a container variable. When a unit is stored, all keys and tags in the unit definition may be manipulated, including some others, with set_variable(). A sample list of these tables and keys can be found at InternalActionsWSLUnitTags.
If you have a doubt about what keys are valid or what the valid value range is for each key, code a store_unit() event, save the game, and examine what keys are in the file (or just examine the [unit] tag(s) in any save file). One can also use the :inspect command or the inspect() function to open a game-state inspector dialog, which can be used to view unit properties.
Common usage is to manipulate a unit by using store_unit() to store it into a variable, followed by manipulation of the variable, and then unstore_unit() to re-create the unit with the modified variables.
Note: stored units also exist on the field, and modifying the stored variable will not automatically change the stats of the units. You need to use unstore_unit(). See also unstore_unit() and FOREACH.]]

    action: (cfg) ->
        filter = cfg.filter or
            wesmere.wsl_error "store_unit missing required filter key"

        --cache the needed units here, since the filter might reference the to-be-cleared variable(s)
        units = wesmere.get_units(filter)
        -- recall_units = wesmere.get_recall_units(filter)

        result = units

        if kill_units = cfg.kill
            for u in *units
                wesmere.erase_unit(u.x, u.y)

        -- if (not filter.x or filter.x == "recall") and (not filter.y or filter.y == "recall")
        --     for u in *recall_units
        --         u.x = "recall"
        --         u.y = "recall"
        --         table.insert(result, u)
        --         if kill_units
        --             wesmere.erase_unit(u)
        if variable = cfg.variable
            wesmere.set_variable(variable, result)
        return result

    scheme:
        filter:
            description: "with a StandardUnitFilter as argument. All units matching this filter will be stored. If there are multiple units, they will be stored into an array of variables. The units will be stored in order of their internal underlying_id attribute, which is usually in creation order (but you normally should not depend on the order)."
        variable:
            description: "the name of the variable into which to store the unit(s)"
            type: "string"
        mode:
            description: "defaults to always_clear, which clears the variable, whether or not a match is found. If mode is set to replace, the variable will not be cleared, and units which match the filter will overwrite existing elements at the start of the array, leaving any additional elements intact if the original array contained more elements than there are units matching the filter. If mode is set to append, the variable will not be cleared, and units which match the filter will be added to the array after the existing elements."
        kill:
            description: "if 'true' the units that are stored will be removed from play. This is useful for instance to remove access to a player's recall list, with the intent to restore the recall list later."
            default: false
