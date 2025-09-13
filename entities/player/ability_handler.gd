extends Node2D
class_name Ability_Handler

@onready var p : Player = get_parent()
@onready var sm: StateMachinePlayer = %SM

@export var sharpness_bar : ProgressBar
@export var sharpness_txt : Label

var max_sharpness : float = 10
var sharpness : float = 0

var abilities : Array
var equipped_abilities : Array ## [0] is Neutral, [1] is Up, [2] is Down / Side

func _ready() -> void:
	sharpness = max_sharpness
	update_sharpness_visual()
	
	for n in %abilities.get_children():
		abilities.append(n.name)
	
	SaveLoad._load()
	equipped_abilities = SaveLoad.SaveFileData.equipped_abilities

func ability_handling(delta: float) -> void:
	if Input.is_action_just_pressed("ability"):
		directional_ability(delta)
		update_sharpness_visual()

var ability_sharpness_cost : int
func directional_ability(delta: float) -> void:
	%slash_sfx2.play()
	if Input.is_action_pressed("Up"): 
		# UP ABILITY
		
		ability_sharpness_cost = sm.find_ability_state(
			equipped_abilities[1]).sharpness_cost
		
		
		sm.change_state(
			equipped_abilities[1]
		)
	
	elif Input.is_action_pressed("Down"): 
		# DOWN ABILITY
		
		ability_sharpness_cost = sm.find_ability_state(
			equipped_abilities[2]).sharpness_cost
		
		
		sm.change_state(
			equipped_abilities[2]
		)
		
	
	else: 
		# NEUTRAL/SIDE ABILITY
		
		ability_sharpness_cost = sm.find_ability_state(
			equipped_abilities[0]).sharpness_cost
		
		
		sm.change_state(
			equipped_abilities[0]
		)
	
	sharpness -= p.sm.current_state.sharpness_cost

func update_sharpness_visual() -> void:
	if sharpness > max_sharpness:
		sharpness = max_sharpness
	
	if sharpness <= 0:
		sharpness = 0
	
	sharpness_bar.max_value = max_sharpness
	sharpness_bar.value = sharpness
	
	sharpness_txt.text = str(
		"Sharp: ",
		roundi(sharpness),
		" / ",
		roundi(max_sharpness)
	)

func update_equippped_abilities() -> void:
	pass
