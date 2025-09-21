extends CharacterBody2D
class_name DoubtWord

@onready var health_component: HealthComponent = %health_component

var dir_to_plr : Vector2
var dist_to_plr : float
var start_moving : bool = false
var parent : Boss1
var target_pos : Vector2
var target_vec2 : Vector2
var txts : Array[String] =[
	"Worthless",
	"Incompetent",
	"Forgettable",
	"Horrendous",
	"Useless",
	"Fraud"
]

const RAND_TARGET_RANGE : float = 500
const SPEED : float = 100

func _ready() -> void:
	var txt_idx : int = randi_range(0, txts.size()-1)
	%text.text = str(txts[txt_idx])
	%HitboxComponent.attack.damage = 3
	target_vec2.x = randf_range(-RAND_TARGET_RANGE, RAND_TARGET_RANGE)
	target_vec2.y = randf_range(-RAND_TARGET_RANGE, RAND_TARGET_RANGE)

func _process(delta: float) -> void:
	target_pos = target_vec2 + Global.player.global_position
	dist_to_plr = global_position.distance_to(Global.player.global_position)
	if abs(dist_to_plr)-50 < RAND_TARGET_RANGE:
		dir_to_plr = global_position.direction_to(Global.player.global_position)
	else:
		dir_to_plr = global_position.direction_to(target_pos)
	
	if health_component.hp > 0 and start_moving:
		velocity = dir_to_plr * SPEED
	else:
		velocity *= 0.95
	
	if parent:
		if parent.health_component.hp <= 0:
			queue_free()

	move_and_slide()

func dead(attack : Attack) -> void:
	var dir_to_atkPos : Vector2 = global_position.direction_to(attack.attack_pos)
	velocity = -dir_to_atkPos * attack.knockback
	
	AudioManager.create_2d_audio(global_position, 
	AudioSettings.types.ENEMY_HIT1)
	AudioManager.create_2d_audio(global_position, 
	AudioSettings.types.ENEMY_HIT2)

func _on_start_move_timer_timeout() -> void:
	start_moving = true
