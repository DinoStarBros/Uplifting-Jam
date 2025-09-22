extends Node2D
class_name Blade
@onready var hitbox_component: HitboxComponent = %HitboxComponent

var velocity : Vector2

var a :bool = false

func _ready() -> void:
	velocity = Vector2.DOWN * 1500
	look_at(global_position + velocity)
	
	hitbox_component.attack.damage = 4
	
	a = randf_range(0,1) > 0.5
	%"Ctweap2-sheet".visible = a
	%CtweapOutline.visible = not a
	
	%"Ctweap2-sheet".frame = randi_range(0, 5)
	%CtweapOutline.frame = randi_range(0,3)

func _process(delta: float) -> void:
	_move(delta)
	
	look_at(global_position + velocity)

func _move(delta: float) -> void:
	global_position += delta * velocity


func _on_life_timer_timeout() -> void:
	queue_free()
