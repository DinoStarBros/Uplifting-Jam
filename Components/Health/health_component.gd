extends Node2D
class_name HealthComponent

@export var max_hp : float = 10
var hp : float

func _ready() -> void:
	hp = max_hp
