extends CharacterBody2D
class_name Player

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("M1"):
		Global.spawn_txt("67!", get_global_mouse_position())


var aim_position : Vector2
var half_viewport : Vector2
func _unhandled_input(event: InputEvent) -> void: ## For camera aiming, dynamic camera follow mouse
	if event is InputEventMouseMotion:
		half_viewport = get_viewport_rect().size / 2.0
		aim_position = (event.position - half_viewport)
