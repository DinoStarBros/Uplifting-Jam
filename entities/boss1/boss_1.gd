extends CharacterBody2D
class_name Boss1

signal EmergeSpikes
signal DeadBoss

@onready var hitbox_component: HitboxComponent = %HitboxComponent
@onready var sm: StateMachineBoss1 = %StateMachine
@onready var anim: AnimationPlayer = %animation
@onready var health_component: HealthComponent = %health_component

const SPEED : float = 500.0
const JUMP_VELOCITY : float = 800.0

var dir_to_plr : Vector2
var last_attack_id : int
var enable_gravity : bool = true
var just_ : bool = false

var attack_pattern : Array[int] = [ # 0 = JUMP, 1 = WORDS, 2 = SPIKES
	0, 0, 1, 2
]
var current_attack_idx : int

func _ready() -> void:
	attack_pattern.shuffle()
	
	get_parent().connect_spike_sig(self)
	get_parent()._dead_boss(self)
	hitbox_component.attack.damage = 5
	hitbox_component.attack.knockback = 600
	start_cutscene()

func _physics_process(delta: float) -> void:
	
	Global.boss_alive = true
	if not is_on_floor() and enable_gravity:
		if velocity.y < 0:
			velocity.y += Global.GRAVITY * delta
		else:
			velocity.y += Global.GRAVITY * delta * 1.5
		
		velocity.y = min(velocity.y, Global.GRAVITY_LIMIT)
	
	move_and_slide()
	
	dir_to_plr = global_position.direction_to(Global.player.global_position)
	
	%sprite.flip_h = dir_to_plr.x > 0

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
	_boss_beat()
	queue_free()

func start_cutscene() -> void:
	GlobalSignals.cutscene_start.emit()

func get_dir_to_plr() -> Vector2:
	return global_position.direction_to(Global.player.global_position)

func _save() -> void:
	SaveLoad.SaveFileData.bosses_beaten = Global.bosses_beaten
	
	SaveLoad._save()

func _boss_beat() -> void:
	Global.boss_alive = false
	if Global.bosses_beaten == 0:
		Global.bosses_beaten = 1
		_save()

var word_scn : PackedScene = preload("res://entities/doubt_word/doubt_word.tscn")

func _spawn_word() -> void:
	var word : DoubtWord = word_scn.instantiate()
	
	word.global_position = global_position
	word.velocity.x = randf_range(-1, 1) * 1500
	word.velocity.y = randf_range(-1, 0.1) * 1500
	word.parent = self
	Global.game.add_child(word)
