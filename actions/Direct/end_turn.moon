wsl_action
    id: "end_turn"
    description: "End the current side's turn. The current event is finished before the turn is ended. Also, if the current event (where the tag appears) has been fired by another event, that event (and the complete stack of other possible parent events) is ended before [end_turn] comes into affect. Also, events following the event stack that fired [end_turn] are not omitted (e.g. [end_turn] is used by a side turn event and a turn refresh event does something afterwards)."

    action: (cfg) ->
        wesmere.end_turn!

    scheme: {}
