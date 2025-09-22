extends Projectile
class_name Dagger

var velocity : Vector2

func _ready() -> void:
	%HitboxComponent.attack.damage = 3
	%HitboxComponent.attack.knockback = 400
	

func _process(delta: float) -> void:
	_move(delta)
	look_at(global_position + velocity)

func _move(delta: float) -> void:
	global_position += delta * velocity
