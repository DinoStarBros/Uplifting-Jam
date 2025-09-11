extends Node2D
class_name Fist

@onready var hitbox_component: HitboxComponent = %HitboxComponent

var starting_velocity : Vector2
var velocity : Vector2
var knockback_dir : Vector2

func _ready() -> void:
	hitbox_component.attack.knockback_direction = knockback_dir
	velocity = starting_velocity
	
	hitbox_component.attack.damage = 20
	hitbox_component.attack.knockback = 1500
	
	hitbox_component.Hit.connect(_on_hit)

func _physics_process(delta: float) -> void:
	velocity *= 0.9
	look_at(velocity + global_position)
	_move(delta)

func _move(delta: float) -> void:
	global_position += velocity * delta

func _on_hit(attack: Attack) -> void:
	Global.frame_freeze(0.1, 0.1)
	Global.cam.screen_shake(10, 0.2)
