wsl_action
    id: "unstore_unit"
    description: "Creates a unit from a game variable, and activates it on the playing field. This must be a specific variable describing a unit, and may not be an array -- to unstore an entire array, iterate over it. The variable is not cleared. See also store_unit(), while() and clear_variable().
Units can be unstored with negative (or zero) hit points. This can be useful if modifying a unit in its LastBreath event (as the unit's death is already the next step), but tends to look wrong in other cases. In particular, it is possible to have units with negative hit points in play. Such units are aberrations, subject to unusual behavior as the game compensates for them. (For example, such units are currently automatically hit–and killed–in combat.) The details of the unusual behavior are subject to change between stable releases without warning."

    action: (cfg) ->
        assert(cfg.variable, "WSLAction unstore_unit: Missing 'variable' key.")
        unit = wesmere.get_variable(cfg.variable)
        assert(Unit)
        assert(type(unit) == Unit, "WSLAction unstore_unit: variable '#{cfg.variable}' isn't of type 'Unit'")
        local loc
        try
            do: -> loc = Loc(cfg)
            catch: (err) ->




        -- if find_vacant
        --    if check_passability
        wesmere.put_unit(unit, loc)

    scheme:
        variable:
            description: "the name of the variable."
            type: "string"

        find_vacant:
            description: "whether the unit should be placed on the nearest vacant tile to its specified location. If this is set to 'false'(default), then any unit on the same tile as the unit being unstored will be destroyed."
            default: false
            type: "bool"

        check_passability:
            description: [[If 'true', checks for terrain passability when placing the unit. This key has no effect if find_vacant:false (no check performed then). Not yet supported!]]
            default: true
            type: "bool"

        text:
            description: "(translatable) floating text to display above the unit, such as a damage amount"
            type: "tString"

        male_text:
            type: "tString"
        female_text:
            description: "(Version 1.13.2 and later only) (translatable) gender-specific versions of the above
-- @param red, green, blue: (default=0,0,0) the color to display the text in. Values vary from 0-255. You may find it convenient to use the {COLOR_HARM} or {COLOR_HEAL} macro instead. (Use {COLOR_HARM} or {COLOR_HEAL} instead of the whole red,green,blue= line.)"
            type: "tString"

        advance:
            description: "(default=true) if true the unit is advanced if it has enough XP. When modifying XP make sure to do it from inside a synchronized event or it may lead to OOS errors especially when several advancement paths exist. Note that advance and post advance events are called, so infinite loops can happen."
            default: true

        fire_event:
            description: "(boolean yes|no, default no) Whether any advance/post advance events shall be fired if an advancement takes place, no effect otherwise."
            default: false
            type: "bool"

        animate:
            description: [[(boolean yes|no, default yes) Whether "levelout" and "levelin" (or fade to white and back) animations shall be played if an advancement takes place, no effect otherwise.]]

        x:
            description: [[override unit location, "x,y=recall,recall" will put the unit on the unit's side's recall list.]]
        y: {}
