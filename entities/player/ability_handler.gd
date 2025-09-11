extends Node2D
class_name Ability_Handler

@onready var p : Player = get_parent()
@onready var sm: StateMachinePlayer = %SM

var abilities : Array
var equipped_abilities : Array ## [0] is Neutral, [1] is Up, [2] is Down, [3] is Side

func _ready() -> void:
	for n in %abilities.get_children():
		abilities.append(n.name)
	
	equipped_abilities = abilities

func ability_handling(delta: float) -> void:
	if Input.is_action_just_pressed("ability"):
		directional_ability(delta)

func directional_ability(delta: float) -> void:
	if Input.is_action_pressed("Up"): 
		# UP ABILITY
		sm.change_state(
			equipped_abilities[1]
		)
		
		
	
	elif Input.is_action_pressed("Down"): 
		# DOWN ABILITY
		sm.change_state(
			equipped_abilities[2]
		)
		
		
	
	elif Input.is_action_pressed("Left") or Input.is_action_pressed("Right"): 
		# SIDE ABILITY
		sm.change_state(
			equipped_abilities[3]
		)
		
		
	
	else: 
		# NEUTRAL ABILITY
		sm.change_state(
			equipped_abilities[0]
		)
		
		
	
