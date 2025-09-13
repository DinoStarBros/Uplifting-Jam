extends Node2D

func _ready() -> void:
	randomize_stuff()

func randomize_stuff() -> void:
	
	scale.x = randf_range(1, 5) * -1

func _process(_delta: float) -> void:
	pass
