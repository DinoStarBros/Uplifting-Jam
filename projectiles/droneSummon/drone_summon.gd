extends Node2D
class_name Drone

var parent : CharacterBody2D
var velocity : Vector2
var target : CharacterBody2D
var dir_to_target : Vector2
var shooty : bool = false
var offset_x : float = 0
var index : int = 0

static var amount : int = 0

const SPEED : float = 4
const BULLET_SPD : float = 600

func _ready() -> void:
	%shootTimer.timeout.connect(_shooty_timeout)
	%lifeTimer.timeout.connect(_lifetimer_timeout)
	amount += 1
	index = amount
	

func _physics_process(delta: float) -> void:
	_move(delta)
	
	offset_x = (index * 50 / amount) * parent.last_x_input
	velocity = (
		(parent.global_position + Vector2(offset_x, -100)) - global_position
		) * SPEED
	
	if %detect_radius.get_overlapping_bodies().size() != 0:
		target = %detect_radius.get_overlapping_bodies()[0]
	if target:
		dir_to_target = global_position.direction_to(target.global_position)
		shooty = true
	else:
		shooty = false

func _move(delta: float) -> void:
	global_position += velocity * delta

var bullet_scn : PackedScene = References.projectiles["bullet"]
func _spawn_bullet() -> void:
	var bullet : Bullet = bullet_scn.instantiate()
	
	bullet.global_position = global_position
	bullet.velocity = dir_to_target * BULLET_SPD
	
	Global.game.add_child(bullet)

func _shooty_timeout() -> void:
	if shooty:
		_spawn_bullet()

func _lifetimer_timeout() -> void:
	queue_free()
	amount -= 1
	index = amount + 1
