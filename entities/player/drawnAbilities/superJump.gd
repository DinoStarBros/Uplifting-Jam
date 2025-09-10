extends StatePlr

func on_enter()-> void:
	await get_tree().process_frame
	p.velocity.y = -200
	p.anim.play("jump")

func process(delta: float)-> void:
	p.velocity.x = p.x_input * p.SPEED
	
	if p.velocity.y >= 0:
		p.sm.change_state("fall")

func on_exit()-> void:
	pass
