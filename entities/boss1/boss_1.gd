extends CharacterBody2D
class_name Boss1

@onready var hitbox_component: HitboxComponent = %HitboxComponent
@onready var sm: StateMachineBoss1 = %StateMachine
@onready var anim: AnimationPlayer = %animation

const SPEED : float = 300.0
const JUMP_VELOCITY : float = 700.0

var dir_to_plr : Vector2

func _ready() -> void:
	hitbox_component.attack.damage = 5
	hitbox_component.attack.knockback = 600
	start_cutscene()

func _physics_process(delta: float) -> void:
	Global.boss_alive = true
	if not is_on_floor():
		if velocity.y < 0:
			velocity.y += Global.GRAVITY * delta
		else:
			velocity.y += Global.GRAVITY * delta * 1.5
		
		velocity.y = min(velocity.y, Global.GRAVITY_LIMIT)
	
	move_and_slide()

func damaged(attack:Attack) -> void:
	
	AudioManager.create_2d_audio(global_position, 
	AudioSettings.types.ENEMY_HIT1)
	AudioManager.create_2d_audio(global_position, 
	AudioSettings.types.ENEMY_HIT2)

func dead(attack:Attack) -> void:
	GlobalSignals.cutscene_start.emit()
	Global.boss_alive = false
	
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
