extends Projectile
class_name B2Slash

var velocity : Vector2

func _ready() -> void:
	%HitboxComponent.attack.damage = 6
	%HitboxComponent.attack.knockback = 600

func _process(delta: float) -> void:
	pass
