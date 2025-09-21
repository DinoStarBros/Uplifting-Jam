extends Node2D
@onready var hitbox_component: HitboxComponent = %HitboxComponent

func _ready() -> void:
	hitbox_component.attack.damage = 5
	hitbox_component.attack.knockback = 600
	hitbox_component.attack.attack_pos = global_position
	hitbox_component.attack.attack_pos.x *= 3
