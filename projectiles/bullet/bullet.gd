extends Projectile
class_name Bullet

@onready var hitbox_component: HitboxComponent = %HitboxComponent

var velocity : Vector2
func _ready() -> void:
	
	hitbox_component.attack.damage = stats.damage
	hitbox_component.attack.knockback = stats.knockback
	hitbox_component.Hit.connect(_on_hit)
	
	%lifeTimer.timeout.connect(_lifetime_timeout)

func _physics_process(delta: float) -> void:
	_move(delta)
	look_at(global_position + velocity)

func _move(delta: float) -> void:
	global_position += velocity * delta
	hitbox_component.attack.knockback_direction = velocity.normalized()

func _on_hit(attack: Attack) -> void:
	queue_free()

func _lifetime_timeout() -> void:
	queue_free()
