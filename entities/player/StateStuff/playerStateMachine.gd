extends Node
class_name StateMachinePlayer

var initial_state : String
var current_state : StatePlr
var previous_state : StatePlr

@export var debug_txt : Label

func _ready()-> void:
	initial_state = get_child(0).name
	
	current_state = find_child(initial_state) as StatePlr
	previous_state = current_state
	current_state.enter()

func _process(_delta:float)-> void:
	debug_txt.text = str(current_state.name)

func change_state(state: String)-> void:
	
	current_state = find_child(state) as StatePlr
	
	if previous_state.name != current_state.name:
		current_state.enter()
	
	if previous_state.name != current_state.name:
		previous_state.exit()
	
	previous_state = current_state
