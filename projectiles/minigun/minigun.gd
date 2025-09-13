extends Node2D
class_name Minigun

@onready var sprite: Sprite2D = %sprite

var dir : Vector2
var velocity : Vector2

const BULLET_SPD : float = 2500

func _ready() -> void:
	if dir.x >= 0:
		%anim.play("start_right")
	else:
		%anim.play("start_left")

func shoot() -> void:
	_spawn_bullet()
	%gunshot.pitch_scale = randf_range(1.0,1.5)
	%gunshot.play(0.08)
	Global.cam.screen_shake(10, 0.05)

var bullet_scn : PackedScene = preload("res://projectiles/bullet/bullet.tscn")

func _spawn_bullet() -> void:
	var bullet : Bullet = bullet_scn.instantiate()
	
	bullet.damage = randi_range(2,3)
	bullet.global_position = %flash.global_position
	bullet.velocity = dir * BULLET_SPD
	Global.game.add_child(bullet)
