extends CharacterBody2D
class_name Dummy

@onready var hitbox_component: HitboxComponent = %HitboxComponent

func _ready() -> void:
	hitbox_component.attack.damage = 1
	hitbox_component.attack.knockback = 600

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += Global.GRAVITY * delta
	
	move_and_slide()
	velocity.x *= 0.9

func damaged(attack:Attack) -> void:
	velocity = attack.knockback_direction * attack.knockback
	
	AudioManager.create_2d_audio(global_position, 
	AudioSettings.types.ENEMY_HIT1)
	AudioManager.create_2d_audio(global_position, 
	AudioSettings.types.ENEMY_HIT2)

func dead(attack:Attack) -> void:
	velocity = attack.knockback_direction * attack.knockback * 3
	
	AudioManager.create_2d_audio(global_position,
	AudioSettings.types.ENEMY_DEATH)
