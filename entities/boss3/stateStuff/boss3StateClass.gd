extends Node
class_name StateBoss3

@onready var p : Boss3 = owner

var state_duration : float = 0 
var is_current : bool = false
@export var sharpness_cost : int = 0

func _ready()-> void:
	exit()

func enter()-> void:
	on_enter()
	set_physics_process(true)

func exit()-> void:
	on_exit()
	set_physics_process(false)

func on_enter()-> void:
	pass

func on_exit()-> void:
	pass

func _physics_process(delta:float)-> void:
	process(delta)

func process(_delta:float)-> void:
	pass
