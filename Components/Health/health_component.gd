extends Node2D
class_name HealthComponent

@export var max_hp : float = 10
@export var dmg_txt : bool = true
var hp : float

func _ready() -> void:
	hp = max_hp

func took_damage(attack : Attack) -> void:
	if dmg_txt:
		Global.spawn_txt(str(roundi(attack.damage)), global_position)
