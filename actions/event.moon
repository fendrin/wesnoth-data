

SUF = (cfg) ->
 --   with cfg



    return cfg

SAF = (cfg) ->
    return cfg

ConditionWSL = (cfg) ->
    return cfg

SSF = (cfg) ->
    return cfg

wsl_action
    id: "event"

    action: (ev) ->

        assert ev

        if ev.name == nil
            error "no name in embeded event" unless ev.name
            print debug.traceback("stack trace")
            wesmere.debug ev


        error "no command in embeded #{ev.name} event" unless ev.command

        if ev.remove
            wesmere.remove_ev(ev)
        else
            wesmere.add_event_handler(ev)

    scheme:
        name:
            description: "hmmm"
        first_time_only:
            description: [[Whether the event should be removed from the scenario after it is triggered. This key takes a boolean; for example:
first_time_only: true
Default behavior if key is omitted. The event will trigger the first time it can and never again.
first_time_only=no
The event will trigger every time the criteria are met instead of only the first time.]]
        id:
            description: [[If an id is specified, then the event will not be added if another event with the same id already exists. An id will also allow the event to be removed, see below. Supplying a non-empty id= is mandatory in case of a [unit_type][event].]]
        remove:
            description: [[Whether to remove an event instead of adding a new one. This key takes a boolean; if true, then the contents of the event are ignored and the event with the specified id is removed instead. (Version 1.13.0 and later only) May be a comma separated list.
[event]
    id=id_of_event_to_remove
    remove=yes
[/event]
Note: (Version 1.13.0 and later only) You can now use [remove_event] instead (the [event] remove= syntax still works). It also accepts a comma separated list.
[remove_event]
    id=id_of_event_to_remove
[/remove_event]
]]
        filter: SUF
            description: [[The event will only trigger if the primary unit matches this filter.
    StandardUnitFilter: selection criteria]]
        filter_second: SUF
            description: [[Like [filter], but for the secondary unit.
    StandardUnitFilter: selection criteria]]
        filter_attack: SAF
            description: [[Can be used to set additional filtering criteria based on the weapon used by the primary unit. This is usable in the events attack, attacker hits, attacker misses, defender hits, defender misses, attack end, last breath, and die. For more information and filter keys, see Filtering Weapons. The most commonly used keys are the following.
    name: the name of the weapon used.
    range: the range of the weapon used.
    special: filter on the attack's special power.]]
        filter_second_attack: SAF
            description: [[Like [filter_attack], but for the weapon used by the secondary unit.]]
        filter_condition: ConditionWSL
            description: [[This tag makes sense inside any sort of event - even those that don't have units, or custom events,... The event will only trigger if this condition evaluates to true.
    Condition Tags
    note: This tag is meant to be used when the firing of an event shall be based on variables/conditions which cannot be retrieved from the filtered units.]]
        filter_side: SSF
            description: [[The current side (usually the side $side_number) must match the passed StandardSideFilter for the event to fire.
    SSF tags and keys as arguments as described in StandardSideFilter.
    note: This tag makes most sense in side turn and turn refresh events. However, all wsl events have a current side so one could also prevent e.g. a moveto event from firing if you put a [filter_side] tag there and the moving unit's side doesn't match.]]
        delayed_variable_substitution:
            type: "bool"
            description: [[This key is only relevant inside of a nested event and controls when variable substitution will occur in those special case actions.]]
