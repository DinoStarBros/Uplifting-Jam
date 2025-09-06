extends Node2D
class_name SplashTXT

var text : String
var velocity : Vector2


func _ready() -> void:
	%text.text = text
	velocity.y = randi_range(-300, -700)
	velocity.x = randi_range(-500, 500)
	
	await get_tree().create_timer(2).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	_move(delta)
	
	velocity.y += Global.GRAVITY * delta

func _move(delta: float) -> void:
	global_position += velocity * delta
