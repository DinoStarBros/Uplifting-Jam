extends CharacterBody2D

@onready var health_component: HealthComponent = %health_component

var dir_to_plr : Vector2

const SPEED : float = 200

func _ready() -> void:
	%HitboxComponent.attack.damage = 3

func _process(delta: float) -> void:
	dir_to_plr = global_position.direction_to(Global.player.global_position)
	
	if health_component.hp > 0:
		velocity = dir_to_plr * SPEED
	move_and_slide()

func dead(attack : Attack) -> void:
	var dir_to_atkPos : Vector2 = global_position.direction_to(attack.attack_pos)
	velocity = -dir_to_atkPos * attack.knockback
	
	AudioManager.create_2d_audio(global_position, 
	AudioSettings.types.ENEMY_HIT1)
	AudioManager.create_2d_audio(global_position, 
	AudioSettings.types.ENEMY_HIT2)
