extends CharacterBody2D
class_name B3Summon
@onready var hitbox_component: HitboxComponent = %HitboxComponent

func _ready() -> void:
	hitbox_component.attack.damage = 4
	hitbox_component.attack.knockback = 600
