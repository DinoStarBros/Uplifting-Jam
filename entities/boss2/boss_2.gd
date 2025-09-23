extends CharacterBody2D
class_name Boss2

signal DeadBoss

@onready var hitbox_component: HitboxComponent = %HitboxComponent
@onready var sm: StateMachineBoss2 = %StateMachine
@onready var anim: AnimationPlayer = %animation
#@onready var sword_hit_b: HitboxComponent = %SwordHitB

const SPEED : float = 150.0
const JUMP_VELOCITY : float = 700.0

var attack_frequencies : Array = [
	0,
	1, 1,
	2, 
	3, 3, 3
]
var current_attack_idx : int
var stop_flip : bool = false

func _ready() -> void:
	attack_frequencies.shuffle()
	
	hitbox_component.attack.damage = 3
	hitbox_component.attack.knockback = 600
	
	%SwordHitB.attack.damage = 5
	
	Global.boss_alive = true

	get_parent()._dead_boss(self)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		if velocity.y < 0:
			velocity.y += Global.GRAVITY * delta
		else:
			velocity.y += Global.GRAVITY * delta * 1.5
		
		velocity.y = min(velocity.y, Global.GRAVITY_LIMIT)
	
	move_and_slide()
	
	var dir_to_plr : Vector2 = global_position.direction_to(Global.player.global_position)
	if not stop_flip:
		%sprite.flip_h = dir_to_plr.x < 0
	if %sprite.flip_h:
		%sprite.position = Vector2(-64, -64)
	else:
		%sprite.position = Vector2(64,-64)

func damaged(attack:Attack) -> void:
	
	AudioManager.create_2d_audio(global_position, 
	AudioSettings.types.ENEMY_HIT1)
	AudioManager.create_2d_audio(global_position, 
	AudioSettings.types.ENEMY_HIT2)

func dead(attack:Attack) -> void:
	GlobalSignals.cutscene_start.emit()
	
	DeadBoss.emit()
	AudioManager.create_2d_audio(global_position,
	AudioSettings.types.ENEMY_DEATH)
	sm.change_state("death")
	
	Global.boss_alive = false

func end_cutscene() -> void:
	GlobalSignals.cutscene_end.emit()
	queue_free()
	Global.boss_alive = false


const dagger_scn : PackedScene = preload("res://projectiles/b2_dagger/b_2_dagger.tscn")
func _spawn_dagger() -> void:
	var dagger : Dagger = dagger_scn.instantiate()
	
	dagger.global_position = global_position
	var dir_to_plr : Vector2 = global_position.direction_to(Global.player.global_position)
	dagger.velocity = 1000 * dir_to_plr
	Global.game.add_child(dagger)

const slash_scn : PackedScene = preload("res://projectiles/b2_slash/b2_slash.tscn")
func _spawn_slash() -> void:
	var slash : B2Slash = slash_scn.instantiate()
	
	slash.global_position = Global.player.global_position
	slash.rotation_degrees = randf_range(-180, 180)
	slash.scale *= 2
	Global.game.add_child(slash)
