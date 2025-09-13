extends StatePlr

const fist_scn : PackedScene = References.projectiles["fist"]

const FIST_DELAY : float = 0.2
var fist_delay_time : float
var fist_spawned : bool = false

func on_enter() -> void:
	state_duration = 0.5
	p.anim.play("draw_side")
	p.velocity.x = 800 * p.last_x_input
	
	fist_spawned = false
	fist_delay_time = FIST_DELAY
	p.velocity.y = 150
	%fist_wind.play()

func process(delta: float)-> void:
	p.velocity *= 0.9
	p.enable_gravity = false
	
	fist_delay_time = max(fist_delay_time - delta, 0)
	if fist_delay_time <= 0:
		if not fist_spawned:
			spawn_fist()
			fist_spawned = true
	
	state_duration = max(state_duration - delta, 0)
	if state_duration <= 0:
		if not p.is_on_floor():
			p.sm.change_state("walk")
		else:
			p.sm.change_state("fall")
	
	if state_duration <= 0.45:
		p.hurtbox.disabled = true

func on_exit()-> void:
	await get_tree().process_frame
	p.hurtbox.disabled = false

func spawn_fist() -> void:
	%fist_go.play()
	var fist : Fist = fist_scn.instantiate()
	fist.global_position = p.global_position
	fist.starting_velocity.x = p.last_x_input * 2500
	fist.knockback_dir = Vector2(p.last_x_input, 0)
	fist.starting_velocity.y = 200
	fist.global_position.y += -50
	Global.game.add_child(fist)
