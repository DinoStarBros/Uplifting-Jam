extends CharacterBody2D
class_name Player

@export var fast_wake_up : bool = false

@onready var sm: StateMachinePlayer = %SM
@onready var anim: AnimationPlayer = %anim
@onready var sprite: Sprite2D = %sprite
@onready var slashnim: AnimationPlayer = %slashnim
@onready var slash_pivot: Node2D = %slash_pivot
@onready var hitbox_component: HitboxComponent = %HitboxComponent
@onready var camera: Cam = %Camera
@onready var ability_handler: Ability_Handler = %ability_handler
@onready var hurtbox: CollisionShape2D = %hurtbox
@onready var hurtbox_component: HurtboxComponent = %hurtbox_component
@onready var health_component: HealthComponent = %health_component

var coyote_time : float = 0
var x_input : int = 1
var last_x_input : int = 1
var y_input : int = 0
var last_y_input : int = 0
var jump_buffer_time : float = 0
var next_buffered_state : String
var enable_gravity : bool = true
var air_dashes : int = 1
var override_flip_sprite : bool = false
var can_slash : bool = true
var can_dash : bool = true
var sharpness_gain : int = 1
var damage: float = 5
var knockback: float = 400
var scene_just_started : bool = true
var iframe_duration : float = 0
var is_slashing : bool = false

const MAX_DASHES : int = 1
const SPEED : float = 400.0
const JUMP_VEL : float = 600.0
const COYOTE_TIME_THRESHOLD : float = 0.15
const DASH_SPEED : float = 1000.0
const DASH_DURATION : float = 0.17
const SLASH_COOLDOWN : float = 0.37
const SLASH_KNOCKBACK : float = 400.0

func _ready() -> void:
	%slashTimer.timeout.connect(_slashCD_timeout)
	hitbox_component.Hit.connect(_hitbox_hit)
	hitbox_component.attack.damage = References.statRes["pencil"].damage
	hitbox_component.attack.knockback = References.statRes["pencil"].knockback
	Global.player = self
	
	GlobalSignals.cutscene_start.connect(_cutscene_start)
	GlobalSignals.cutscene_end.connect(_cutscene_end)

func _physics_process(delta: float) -> void:
	
	sprite.visible = not is_slashing
	%slashprite.visible = is_slashing
	%slashprite.flip_h = sprite.flip_h
	
	iframe_duration = max(iframe_duration - delta, 0)
	%hurtbox.disabled = iframe_duration > 0
	
	if not is_on_floor():
		if enable_gravity:
			if velocity.y < 0:
				velocity.y += Global.GRAVITY * delta
			else:
				velocity.y += Global.GRAVITY * delta * 1.5
		coyote_time += delta
		
		velocity.y = min(velocity.y, Global.GRAVITY_LIMIT)
		
	else:
		air_dashes = MAX_DASHES
		coyote_time = 0
	
	_x_input_handling()
	_y_input_handling()
	move_and_slide()

func _x_input_handling() -> void:
	if Input.is_action_pressed("Right"):
		x_input = 1
		last_x_input = 1
	elif Input.is_action_pressed("Left"):
		x_input = -1
		last_x_input = -1
	else:
		x_input = 0
	
	if not override_flip_sprite:
		sprite.flip_h = last_x_input == -1

func _y_input_handling() -> void:
	if Input.is_action_pressed("Down"):
		y_input = 1
		last_y_input = 1
	elif Input.is_action_pressed("Up"):
		y_input = -1
		last_y_input = -1
	else:
		y_input = 0

func move_handling() -> void:
	if not Global.game_state == Global.GAME_STATES.MAIN:
		return
	
	velocity.x = x_input * SPEED

func _slash_dir_handling() -> void:
	if y_input == 0:
		if last_x_input == 1: # Right
			_play_side_slashnim()
			slash_pivot.rotation_degrees = 0
			hitbox_component.attack.knockback_direction = Vector2.RIGHT
			
		elif last_x_input == -1: # Left
			_play_side_slashnim()
			slash_pivot.rotation_degrees = 180
			hitbox_component.attack.knockback_direction = Vector2.LEFT
			
	else:
		if y_input == 1: # Down
			%slashPriteNim.play("slash_down")
			if is_on_floor():
				if last_x_input == 1: # Right
					_play_side_slashnim()
					slash_pivot.rotation_degrees = 0
					hitbox_component.attack.knockback_direction = Vector2.RIGHT
					
				elif last_x_input == -1: # Left
					_play_side_slashnim()
					slash_pivot.rotation_degrees = 180
					hitbox_component.attack.knockback_direction = Vector2.LEFT
			else:
				slash_pivot.rotation_degrees = 90
				hitbox_component.attack.knockback_direction = Vector2.DOWN
			
		elif y_input == -1: # Up
			%slashPriteNim.play("slash_up")
			slash_pivot.rotation_degrees = -90
			hitbox_component.attack.knockback_direction = Vector2.UP

var buffer_slash : bool = false
func slash_handling() -> void:
	if not Global.game_state == Global.GAME_STATES.MAIN:
		return
	
	if (Input.is_action_just_pressed("slash") or buffer_slash) and can_slash:
		
		%slash.scale.y *= -1
		_slash_dir_handling()
		slashnim.play("slash")
		can_slash = false
		buffer_slash = false
		%slashTimer.start(SLASH_COOLDOWN)
		
		%slash_sfx.pitch_scale = randf_range(0.8, 1.2)
		%slash_sfx.play()
		
	
	if %slashTimer.time_left <= SLASH_COOLDOWN * 0.5:
		if Input.is_action_just_pressed("slash"):
			buffer_slash = true

func _play_side_slashnim() -> void:
	if %slash.scale.y > 0:
		%slashPriteNim.play("slash1")
	else:
		%slashPriteNim.play("slash2")

func _slashCD_timeout() -> void:
	can_slash = true

func dash_handling() -> void:
	if not Global.game_state == Global.GAME_STATES.MAIN:
		return
	
	if Input.is_action_just_pressed("dash") and air_dashes >= 1:
		sm.change_state("dash")

func _hitbox_hit(attack:Attack) -> void:
	ability_handler.sharpness += sharpness_gain
	ability_handler.update_sharpness_visual()
	
	AudioManager.create_2d_audio(global_position, 
	AudioSettings.types.ENEMY_HIT3)
	
	Global.frame_freeze(0.1, 0.075)
	camera.screen_shake(5, 0.1)
	
	#if y_input != 0: # Y Stuff
	if slash_pivot.rotation_degrees == 90: # POGO
		sm.change_state("walk")
		sm.change_state("pogoJump")
	
	else: # X stuff
		if slash_pivot.rotation_degrees != -90:
			sm.change_state("slashKnockback")
	
	velocity.x = attack.knockback_direction.x * -SLASH_KNOCKBACK

func ability_handling(delta: float) -> void:
	ability_handler.ability_handling(delta)

func damaged(attack:Attack) -> void:
	Global.frame_freeze(0.5, 0.1)
	Global.cam.screen_shake(7, 0.1)
	var dir_atk_pos : Vector2 = global_position.direction_to(attack.attack_pos)
	velocity = -dir_atk_pos * attack.knockback
	sm.change_state("damaged")
	
	AudioManager.create_2d_audio(global_position, 
	AudioSettings.types.ENEMY_HIT1)
	AudioManager.create_2d_audio(global_position, 
	AudioSettings.types.ENEMY_HIT2)

func dead(attack:Attack) -> void:
	Global.frame_freeze(0.2, 0.5)
	Global.cam.screen_shake(20, 1)
	velocity = attack.knockback_direction * attack.knockback * 4
	
	sm.change_state("dead")
	AudioManager.create_2d_audio(global_position,
	AudioSettings.types.ENEMY_DEATH)

var hitspark_scn : PackedScene = preload("res://juices/hitspark/hitspark.tscn")
func _spawn_hitspark_death() -> void:
	var hitspark : Hitspark = hitspark_scn.instantiate()
	
	hitspark.global_position = global_position
	hitspark.scale = Vector2(3,3)
	hitspark.look_at(global_position + velocity)
	hitspark.rotation_degrees += 180
	Global.game.add_child(hitspark)

func _cutscene_start() -> void:
	sm.change_state("cutscene")

func _cutscene_end() -> void:
	sm.change_state("walk")

func _on_exit_area_area_entered(area: Area2D) -> void:
	if area.name == "exit_area":
		sm.change_state("exit")

func _reload_scene() -> void:
	SceneManager.reload_scene()

func _slashing() -> void:
	is_slashing = not is_slashing
