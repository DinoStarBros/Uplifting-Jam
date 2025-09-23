extends StateBoss1

var gswave_spawned : bool = false
var fallSFX_played : bool = false
var plr_pos : Vector2
var dir_to_plr : Vector2

var enable_gravity_timer : float = 0
func on_enter() -> void:
	p.anim.play("jump")
	%jump.play()
	state_duration = 3
	
	p.velocity.y = -p.JUMP_VELOCITY
	
	enable_gravity_timer = 1.5
	
	gswave_spawned = false
	fallSFX_played = false

func process(delta: float) -> void:
	plr_pos = Global.player.global_position
	dir_to_plr = p.global_position.direction_to(plr_pos)
	
	if p.velocity.y >= 0:
		p.enable_gravity = false
	
	enable_gravity_timer = max(enable_gravity_timer - delta, 0)
	if enable_gravity_timer <= 0:
		p.enable_gravity = true
	
	#if p.velocity.y <= 0:
	p.velocity.x = dir_to_plr.x * p.SPEED
	#p.velocity.x = plr_pos.x - p.global_position.x
	
	state_duration = max(state_duration - delta, 0)
	if state_duration <= 0:
		p.sm.change_state("walk")
	
	if p.is_on_floor() and not gswave_spawned:
		p.sm.change_state("walk")
		_spawn_ground_shockwave(1)
		_spawn_ground_shockwave(-1)
		gswave_spawned = true
		p.velocity.x = 0
	
	if p.velocity.y >= 0 and not fallSFX_played:
		%falling.play()
		fallSFX_played = true

func on_exit()-> void:
	pass

var ground_shockwave_scn : PackedScene = References.projectiles["ground_shockwave"]
func _spawn_ground_shockwave(x_dir: int) -> void:
	%gswave.play(0.13)
	%falling.stop()
	
	Global.cam.screen_shake(20, 0.2)
	
	var ground_shockwave : GroundShockwave = ground_shockwave_scn.instantiate()
	
	ground_shockwave.global_position = p.global_position
	ground_shockwave.global_position.y += 60
	ground_shockwave.x_dir = x_dir
	
	Global.game.add_child(ground_shockwave)
