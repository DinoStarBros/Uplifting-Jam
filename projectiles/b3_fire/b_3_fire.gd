extends Projectile
class_name B3Fire
@onready var hitbox_component: HitboxComponent = %HitboxComponent

var velocity : Vector2

func _ready() -> void:
	hitbox_component.attack.damage = 1

func _process(delta: float) -> void:
	_move(delta)

func _move(delta: float) -> void:
	global_position += velocity * delta
