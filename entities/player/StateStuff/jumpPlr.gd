extends StatePlr

func on_enter()-> void:
	p.velocity.y = -p.JUMP_VEL
	p.anim.play("jump")
	
	%jump_sfx.pitch_scale = randf_range(1.2,1.5)
	%jump_sfx.play(0.)

func process(delta: float)-> void:
	p.velocity.x = p.x_input * p.SPEED
	p.slash_handling()
	p.ability_handling(delta)

	
	if not Input.is_action_pressed("jump"):
		p.velocity.y = 0
	
	if p.velocity.y >= 0:
		p.sm.change_state("fall")
	
	p.dash_handling()

func on_exit()-> void:
	pass
