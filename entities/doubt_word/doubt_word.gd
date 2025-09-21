extends CharacterBody2D

var dir_to_plr : Vector2

const SPEED : float = 400

func _ready() -> void:
	%HitboxComponent.attack.damage = 3

func _process(delta: float) -> void:
	dir_to_plr = global_position.direction_to(Global.player.global_position)
	
	velocity = dir_to_plr * SPEED
	move_and_slide()
