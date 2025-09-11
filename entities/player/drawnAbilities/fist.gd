extends StatePlr


func on_enter()-> void:
	state_duration = 0.5
	p.anim.play("draw_side")
	p.velocity.x = 2000 * p.last_x_input

func process(delta: float)-> void:
	p.velocity.y = 0
	p.velocity.x *= 0.9
	p.enable_gravity = false

	state_duration = max(state_duration - delta, 0)
	if state_duration <= 0:
		p.sm.change_state("walk")

func on_exit()-> void:
	pass
