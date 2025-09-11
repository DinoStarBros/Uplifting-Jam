extends Node2D
class_name Bullet

@onready var hitbox_component: HitboxComponent = %HitboxComponent

var velocity : Vector2
func _ready() -> void:
	hitbox_component.attack.damage = 4
	hitbox_component.attack.knockback = 100
	hitbox_component.Hit.connect(_on_hit)

func _physics_process(delta: float) -> void:
	_move(delta)
	look_at(global_position + velocity)

func _move(delta: float) -> void:
	global_position += velocity * delta

func _on_hit(attack: Attack) -> void:
	queue_free()
