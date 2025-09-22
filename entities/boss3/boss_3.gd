extends CharacterBody2D
class_name Boss3

signal DeadBoss

@onready var hitbox_component: HitboxComponent = %HitboxComponent
@onready var sm: StateMachineBoss3 = %StateMachine

const SPEED : float = 150.0
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
