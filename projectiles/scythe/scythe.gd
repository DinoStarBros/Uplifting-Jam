extends Node2D
class_name Scythe
@onready var hitbox_component: HitboxComponent = %HitboxComponent

var velocity: Vector2

func _ready() -> void:
	hitbox_component.attack.damage = 8
	hitbox_component.attack.knockback = 600

func _process(delta: float) -> void:
	_move(delta)

func _move(delta: float) -> void:
	global_position += delta * velocity

func _on_life_timer_timeout() -> void:
	queue_free()

func _on_turn_timer_timeout() -> void:
	velocity *= -1
