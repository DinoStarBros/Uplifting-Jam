extends Projectile
class_name Fist

@onready var hitbox_component: HitboxComponent = %HitboxComponent

var starting_velocity : Vector2
var velocity : Vector2
var knockback_dir : Vector2
var p: Player

func _ready() -> void:
	hitbox_component.attack.knockback_direction = knockback_dir
	
	hitbox_component.attack.damage = stats.damage
	hitbox_component.attack.knockback = stats.knockback
	
	hitbox_component.Hit.connect(_on_hit)
	%delaySend.timeout.connect(_delay_timeout)
	look_at(starting_velocity + global_position)

func _physics_process(delta: float) -> void:
	velocity *= 0.8
	look_at(velocity + global_position)
	_move(delta)

func _move(delta: float) -> void:
	global_position += velocity * delta

func _on_hit(attack: Attack) -> void:
	Global.frame_freeze(0.1, 0.1)
	Global.cam.screen_shake(15, 0.2)
	p.velocity.x = -knockback_dir.x * 500

func _delay_timeout() -> void:
	velocity = starting_velocity
	%hitbox.disabled = false
