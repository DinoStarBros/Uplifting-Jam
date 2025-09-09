extends StatePlr

func on_enter()-> void:
	p.velocity.y = -p.JUMP_VEL
	p.anim.play("jump")

func process(delta: float)-> void:
	p.velocity.x = p.x_input * p.SPEED
	p.slash_handling()
	
	if not Input.is_action_pressed("jump"):
		p.velocity.y = 0
	
	if p.velocity.y >= 0:
		p.sm.change_state("fall")
	
	p.dash_handling()

func on_exit()-> void:
	pass
