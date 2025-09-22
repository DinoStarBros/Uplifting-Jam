extends CharacterBody2D
class_name Boss3

signal DeadBoss

@onready var hitbox_component: HitboxComponent = %HitboxComponent
@onready var sm: StateMachineBoss3 = %StateMachine
@onready var anim: AnimationPlayer = %animation

const SPEED : float = 120.0
const JUMP_VELOCITY : float = 700.0

var attack_frequencies : Array = [
	0, 1, 2
]
var current_attack_idx : int

func _ready() -> void:
	hitbox_component.attack.damage = 8
	hitbox_component.attack.knockback = 600
	
	get_parent()._dead_boss(self)

func _physics_process(delta: float) -> void:
	Global.boss_alive = true
	
	move_and_slide()

func damaged(attack:Attack) -> void:
	
	AudioManager.create_2d_audio(global_position, 
	AudioSettings.types.ENEMY_HIT1)
	AudioManager.create_2d_audio(global_position, 
	AudioSettings.types.ENEMY_HIT2)

func dead(attack:Attack) -> void:
	GlobalSignals.cutscene_start.emit()
	Global.boss_alive = false
	
	DeadBoss.emit()
	AudioManager.create_2d_audio(global_position,
	AudioSettings.types.ENEMY_DEATH)
	sm.change_state("death")

func end_cutscene() -> void:
	GlobalSignals.cutscene_end.emit()
	queue_free()
	Global.change_scene("res://screens/congrats/congrats.tscn")

func move_to_plr() -> void:
	velocity.x = -SPEED

const laser_scn : PackedScene = preload("res://projectiles/b3_laser/b_3_laser.tscn")
func _spawn_laser() -> void:
	var laser : B3Laser = laser_scn.instantiate()
	
	laser.global_position = global_position
	laser.look_at(Global.player.global_position)
	laser.scale.x *= 8
	Global.game.add_child(laser)

const fire_scn : PackedScene = preload("res://projectiles/b3_fire/b_3_fire.tscn")
var dir_to_plr : Vector2
func _spawn_fire(hole: int) -> void:
	var fire : B3Fire = fire_scn.instantiate()
	
	match hole:
		0:
			fire.global_position = %f1.global_position
			dir_to_plr = %f1.global_position.direction_to(Global.player.global_position)
		1:
			fire.global_position = %f2.global_position
			dir_to_plr = %f2.global_position.direction_to(Global.player.global_position)
		2:
			fire.global_position = %f3.global_position
			dir_to_plr = %f3.global_position.direction_to(Global.player.global_position)
	
	
	fire.velocity = dir_to_plr * 700
	fire.velocity.y += randf_range(-100, 100)
	
	
	Global.game.add_child(fire)
