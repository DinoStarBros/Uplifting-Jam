extends Area2D
class_name SpawnBossArea

signal BossStart

@export var boss_scn : PackedScene

var spawn_pos : Node2D

func _ready() -> void:
	for n in get_children():
		if n is Node2D:
			spawn_pos = n

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		_spawn_boss()
		BossStart.emit()
		queue_free()

func _spawn_boss() -> void:
	var boss : CharacterBody2D = boss_scn.instantiate()
	
	boss.global_position = spawn_pos.global_position
	
	Global.game.add_child(boss)
