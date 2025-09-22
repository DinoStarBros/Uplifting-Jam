extends Projectile
class_name Sword
@onready var hitbox_component: HitboxComponent = %HitboxComponent

var velocity : Vector2
var target : CharacterBody2D
var dir_to_target : Vector2
var rand_vec2 : Vector2

const SPD : float = 400

func _ready() -> void:
	hitbox_component.attack.damage = 2
	rand_vec2.x = randf_range(-50, 50)
	rand_vec2.y = randf_range(-50, 50)
	
	velocity.x = randf_range(-SPD, SPD)

func _on_life_timer_timeout() -> void:
	queue_free()

func _process(delta: float) -> void:
	_move(delta)
	look_at(global_position + velocity)

	if %detect_area.get_overlapping_bodies().size() != 0:
		target = %detect_area.get_overlapping_bodies()[0]
	if target:
		dir_to_target = global_position.direction_to(target.global_position + rand_vec2)
		velocity = dir_to_target * SPD

func _move(delta: float) -> void:
	global_position += delta * velocity
