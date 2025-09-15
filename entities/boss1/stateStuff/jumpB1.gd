extends StateBoss1

var gswave_spawned : bool = false
var fallSFX_played : bool = false
func on_enter() -> void:
	
	%jump.play()
	state_duration = 2
	
	p.velocity.y = -p.JUMP_VELOCITY
	p.dir_to_plr = p.get_dir_to_plr()
	p.velocity.x = p.SPEED * (p.dir_to_plr.x / 2)
	
	gswave_spawned = false
	fallSFX_played = false

func process(delta: float) -> void:
	state_duration = max(state_duration-delta, 0)
	if state_duration <= 0:
		p.sm.change_state("walk")
	
	if p.is_on_floor() and not gswave_spawned:
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
	ground_shockwave.global_position.y += 120
	ground_shockwave.x_dir = x_dir
	
	Global.game.add_child(ground_shockwave)
