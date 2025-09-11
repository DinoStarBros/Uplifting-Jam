extends StatePlr

const fist_scn : PackedScene = References.projectiles["fist"]
func on_enter()-> void:
	state_duration = 0.5
	p.anim.play("draw_side")
	p.velocity.x = 1500 * p.last_x_input
	
	var fist : Fist = fist_scn.instantiate()
	fist.global_position = p.global_position
	fist.starting_velocity.x = p.last_x_input * 2500
	fist.knockback_dir = Vector2(p.last_x_input, 0)
	fist.starting_velocity.y = 200
	fist.global_position.y += -50
	Global.game.add_child(fist)
	
	p.velocity.y = 150

func process(delta: float)-> void:
	p.velocity.x *= 0.9
	p.velocity.y *= 0.9
	p.enable_gravity = false

	state_duration = max(state_duration - delta, 0)
	if state_duration <= 0:
		p.sm.change_state("walk")
	
	if state_duration <= 0.45:
		p.hurtbox.disabled = true

func on_exit()-> void:
	await get_tree().process_frame
	p.hurtbox.disabled = false
