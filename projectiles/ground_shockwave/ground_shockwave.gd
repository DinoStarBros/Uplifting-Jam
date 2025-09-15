extends Projectile
class_name GroundShockwave

@onready var hitbox_component: HitboxComponent = %HitboxComponent

var velocity : Vector2
var x_dir : int
var speed_mult_gain : float = 0

const SPEED : float = 800

func _ready() -> void:
	stats = References.statRes["ground_shockwave"]
	
	hitbox_component.attack.damage = stats.damage
	hitbox_component.attack.knockback = stats.knockback
	hitbox_component.Hit.connect(_on_hit)
	
	%lifeTimer.timeout.connect(_lifetime_timeout)
	
	%Explosion.flip_h = x_dir == 1

func _physics_process(delta: float) -> void:
	_move(delta)
	
	speed_mult_gain = min(speed_mult_gain + delta, 1.5)
	velocity.x = x_dir * SPEED * speed_mult_gain

func _move(delta: float) -> void:
	global_position += velocity * delta
	hitbox_component.attack.knockback_direction = velocity.normalized()

func _on_hit(attack: Attack) -> void:
	pass

func _lifetime_timeout() -> void:
	queue_free()
