extends Node
class_name StateMachineBoss2

var initial_state : String
var current_state : StateBoss2
var previous_state : StateBoss2

@export var debug_txt : Label

func _ready()-> void:
	initial_state = get_child(0).name
	
	current_state = find_child(initial_state)
	previous_state = current_state
	current_state.enter()

func _process(_delta:float)-> void:
	if debug_txt:
		debug_txt.text = str(current_state.name)

func change_state(state: String)-> void:
	
	current_state = find_child(state) as StateBoss2
	
	if previous_state.name != current_state.name:
		current_state.enter()
		current_state.is_current = true
	
	if previous_state.name != current_state.name:
		previous_state.exit()
		previous_state.is_current = false
	
	previous_state = current_state

func find_state(state_name : String) -> StateBoss2:
	return find_child(state_name)
