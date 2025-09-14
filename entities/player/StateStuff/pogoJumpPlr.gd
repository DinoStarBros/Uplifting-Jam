extends StatePlr

func on_enter()-> void:
	p.velocity.y = -p.JUMP_VEL * 0.6
	p.anim.play("jump")
	
	p.air_dashes = p.MAX_DASHES

func process(delta: float)-> void:
	p.move_handling()
	p.slash_handling()
	p.ability_handling(delta)
	
	if p.velocity.y >= 0:
		p.sm.change_state("fall")
	
	p.dash_handling()
	


func on_exit()-> void:
	pass
