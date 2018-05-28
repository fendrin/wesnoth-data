
wsl_action
    id: "replace_map"
    description: "Replaces the entire map.
Note: When a hex changes from a village terrain to a non-village terrain, and a team owned that village it loses that village. When a hex changes from a non-village terrain to a village terrain and there is a unit on that hex it does not automatically capture the village. The reason for not capturing villages it that there are too many choices to make; should a unit lose its movement points, should capture events be fired. It is easier to do this as wanted by the author in WSL."

    action: (cfg, kernel) ->
        kernel\print("'replace_map' not implemented yet.")

    scheme:
        map:
            description: [[Content of a wesmere map file. example:
-- map="{campaigns/Heir_To_The_Throne/maps/01_The_Elves_Besieged.map}"]]

        expand:
            description: "if 'yes', allows the map size to increase. The expansion direction is currently always bottom-right."

        shrink:
            description: "if 'yes', allows the map size to decrease. If the map size is reduced, any units that would no longer be on the map due to its coordinates no longer existing will be put into the recall list."
