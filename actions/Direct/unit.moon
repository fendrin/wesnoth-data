wsl_action
    id: "unit"

    action: (cfg) ->
        assert(cfg, "WSLAction unit: Missing argument table.")
        try
            do: -> wesmere.put_unit(cfg)
            catch: (err) -> error "WSLAction unit: #{err}"

    description: [["This tag, [unit], describes a single unit on the map, for example Konrad. It is different from the [unit_type] in [units], which describes a class of units. However it takes many of the same keys and thus can generally override the inherited properties from the associated [unit_type].
[unit] can be used inside [side] (SideWML) for units present at start of the scenario, or as DirectActionsWML for units created during the game. (It is also used in save-files.)
The following keys are recognized:
type: the ID of the unit's unit type. See UnitTypeWML.
parent_type: overrides type if this is present. This is likely of little use to WML authors; it is automatically generated when needed by the game (to keep track of some [unit_type][variation]s).
side: the side that the unit is on. It has to be an existing side, even if the unit is created in a variable.
gender: can be set to male or female to designate the gender of the unit. Default is male, but if the unit has only a female variant it will be female.
x, y: the location of the unit. By default ( see placement) if a location isn't provided and the side the unit will belong to has a recall list, the unit will be created on the recall list.
placement: How the unit should be placed: can be one value or a comma-separated list of values. Default value is 'map,leader' for a leader given directly in [side], "" otherwise. By default, 'map,recall' is implicitly appended to the end of the list.
map: If x,y are explicitly given and point to a valid on-map location - try to place the unit at the nearest free location to there, never overwriting existing units. Successful if x,y are given and a valid on-map vacant location near it can be found.
leader: Try to place unit near the leader, if leader is not present or is in recall list - try to place unit near the start location for this side. Successful if a valid on-map vacant location can be found near leader or near start location.
recall: Place unit on recall list. Always successful.
map_overwrite: If x,y are explicitly given and point to a valid on-map location - try to place unit at this location, if there was a unit there - overwriting it, without firing events.
map_passable: If x,y are explicitly given and point to a valid on-map location - try to place unit at this location; if the hex is of an impassable terrain for the unit being placed, or is already occupied by another unit, the new unit will be placed in the nearest vacant hex.
leader_passable: Similar to "leader", with the additional restriction that the selected location is not impassable for the unit being placed.
to_variable: creates the unit into the given variable instead of placing it on the map.
id: a unique identifier for the unit. This is (usually) not displayed to the player, but is to be used only for identifying and filtering units. If not specified or when a unit is normally recruited, a random one will be generated for the unit to ensure that each unit has a unique id attribute. In older versions, the description attribute specified a unique ID. (The one instance when an id is displayed to the player is when the leader's id is used as the default for a side's current_player attribute.)
name: the user-visible name of the unit. Note that the player may use the "rename unit" action to change this.
generate_name: (default=yes) will generate a new name if there isn't one specifed for the unit, as if the unit were a freshly-recruited one
unrenamable: if 'yes', the user-visible name of the unit cannot be changed by the player (which is only possible when the unit is on the player's side anyway).
traits_description: the description of the unit's traits which is displayed. However if it is not specified explicitly, the unit's actual traits' names will be used instead, so it is normally not necessary to set this.
random_traits: "no" will prevent random trait generation for units. You should only need to set this for placed nonleaders in multiplayer games or if you want to give a unit less traits than it would normally get for its unit type. When generating traits for a unit, first traits the unit has already been given are excluded. Then "musthave" traits (undead, mechanical) for the unit type are given. Then for leaders (canrecruit=yes) traits that are not available to "any" (currently that's all of them to avoid a multiplayer OOS issue, but later will be restricted based on multiplayer play balance issues) are removed from consideration. Then traits are added randomly until the maximum allowed for the unit type is reached or there are no more available traits. Random traits can now be used in MP games but only when spawned in an event, so not for leaders and other units in the [side] definition.
random_gender: "yes" will cause the gender of the unit with male and female variations to be male 50% of the time, female 50% of the time. If the unit has only one gender variant it will always be given the correct one.
canrecruit: a special key for leaders.
no: default. Unit cannot recruit.
yes: unit can recruit.
Normally when a team controls no units with canrecruit=yes, that team loses. However, even if your team has lost you continue to play with whatever units you still have until the scenario is over. Usually scenarios end when only one team is left with a leader that can recruit, but special victory conditions can be set up in campaigns. Normally you want to set the leader of a side with canrecruit=yes. If you don't want the leader to recruit, it is usually better to just not give him any unit types to recruit, than to make a special victory condition. Units with canrecruit=yes are exempt from upkeep costs. So that leaders do not need to be given the loyal trait.
More than one unit with canrecruit=yes for the same side (see SideWML) are allowed in single player, if the side is human-controlled.
extra_recruit: a list of unit types which this unit can recruit in addition to the ones given by its [side]recruit=, only working for units with canrecruit=yes.
variation: the variation of itself the unit should be created as.
upkeep: the amount of upkeep the unit costs.
loyal: no upkeep cost. Can be changed by the effect 'loyal' (see EffectWML)
free: synonymous with "loyal".
full: unit costs level upkeep (see UnitTypeWML).
An integer can be used to set the upkeep cost to that number.
The default is "full".
Leaders (units with canrecruit=yes) never pay upkeep no matter what upkeep is set to.
Normally you don't want to muck with this value. If you want to give a side units without upkeep costs, give those units the 'loyal' trait.
(Version 1.13.0 and later only) recall_cost: the recall cost of this unit. Overrides the values specified by the unit's type ([unit_type]), its side ([side]), and the global [game_config] value. A value of -1 is equivalent to not specifying this attribute.
overlays: a list of images that are overlayed on the unit.
goto_x:, goto_y: UI settings that control courses. Default is 0,0 i.e. the unit is not on a course.
hitpoints: the HP of the unit. Default is the max HP for type.
hp_bar_scalling: Overwrites the attribute in (GameConfigWML).
experience: the XP of the unit. Default is 0.
moves: number of movement points the unit has left. Default is the movement for its unit type.
Note: Do not assume that moves=max_moves on turns when a unit doesn't move. The wesnoth AIs sometimes manipulate the moves variable during its turn, for internal reasons.
attacks_left: number of attacks the unit has left. Default is equal to the attacks key for its unit type, that usually is 1 (see max_attacks below).
resting: whether the unit has not moved yet this turn. Used to decide whether to give a unit rest healing.
role: used in standard unit filter (FilterWML). Can be set using [role] (see InternalActionsWML).
ai_special: causes the unit to act differently
"guardian" the unit will not move, except to attack something in the turn it moves (so, it only can move if an enemy unit gets within range of it). Does the same as [status] guardian = 'yes'.
facing: which way the unit is facing (this only affects how the unit is displayed).
Possible values are se, s, sw, nw, n, ne. Using sw is preferred for a "reversed" facing (looking to the left) and se for a normal (looking to the right) facing.
profile: sets a portrait image for this unit. If the unit type already has a portrait set, this is used instead for this unit. When the unit advances, if the value of profile is different from the unit-type portrait, that value is preserved. If the profile field is empty or the same as the unit-type portrait, the level-advance changes the unit portrait to the default for the new level and type. See UnitTypeWML for the rules used for locating files.
"unit_image" if given instead of a filename, uses the unit's base image as the portrait (in the same manner that unit types without portraits do by default).
small_profile: sets a small portrait image for this unit. See the profile attribute above for advancement and special values. As with UnitTypeWML, the location heuristic of the profile attribute is disabled when the small_profile attribute is provided.
max_attacks: Default is 1. The number of attacks the unit can have per turn.
max_experience: The experience the unit needs to advance. If left out, this information will be taken from the unit's file.
max_hitpoints: The maximum hitpoints the unit has. If left out, this information will be taken from the unit's file.
max_moves: The maximum moves the unit has. If left out, this information will be taken from the unit's file.
animate: if yes, fades the unit in like when it's recruited/recalled.
[status] the status of the unit. This affects different features of the unit, for example whether the unit loses health each turn. Default for all keys is 'no', but this can be changed by the scenario or by special abilities (see AbilitiesWML). The Status Table displays the status of each unit using the three images misc/poisoned.png, misc/slowed.png and misc/petrified.png; other keys do not appear in the Status Table.
poisoned: if 'yes', the unit loses 8 HP each turn. See also heals, cures, AbilitiesWML.
slowed: if 'yes', the unit has 50% of its normal movement and does half damage. When the controller of the unit's turn is over, slowed is set to 'no'.
petrified: if 'yes', the unit cannot move, attack, or be attacked.
uncovered: if 'yes', the unit has performed an action (e.g. attacking) that causes it to no longer be hidden until the next turn.
guardian: if 'yes', the unit will not move, except to attack something in the turn it moves (so, it only can move if an enemy unit gets within range of it). Does the same as ai_special = "guardian".
unhealable: if set to 'yes', the unit cannot be healed.
One can add other keys to [status], but they must have boolean values. For example, a scenario can set unit.status.my_custom_key to 'yes' or 'no'.
[variables] a set of variables that will be stored when this unit is stored (See [store_unit], InternalActionsWML). The attribute variable=value means that when the unit is stored in the array unit, the variable unit.variables.variable will have the value value (See VariablesWML).
[modifications] changes that have been made to the unit.
[trait] a trait the unit has. Same format as [trait], UnitsWML.
[object] an object the unit has. Same format as [object], DirectActionsWML.
[advance] an advancement the unit has. Same format as [advancement], UnitTypeWML. Might be used if the unit type has some advancements, but this particular one is supposed to have some of them already taken. (Version 1.13.2 and later only) In 1.13.2 and later this has been renamed to [advancement], to match the UnitTypeWML tag of the same name.
[filter_recall] A leader can only recall those units which pass the SUF.
StandardUnitFilter tags and keys
unit_description: overrides the unit type description for this unit. You will probably want to set up a post_advance event to override the default description after promotions. Or better, use an object with a profile effect(s) to filter on unit type and change the unit description and/or portrait.
[event] The event is copied from this unit's wml description into the scenario. The event is carried along with the unit (it can advance etc) and inserted into every scenario where this unit is first created. A [unit][event] requires a non-empty id= attribute.
[ai] This affects how the computer will control this unit (currently only used by FormulaAI).
formula: if set, the unit will execute this code during the "unit_formulas" stage, assuming that the "unit_formulas" stage has been enabled for this side
priority, loop_formula, [vars]: see the FormulaAI documentation for details"]]

