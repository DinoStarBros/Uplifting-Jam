extends StatePlr

func on_enter() -> void:
	pass

func process(delta: float)-> void:
	p.velocity.x *= 0.8
	
	
	p.slash_handling()
	
	if abs(p.velocity.x) < 30:
		p.sm.change_state("walk")
	
	p.dash_handling()

func on_exit()-> void:
	pass
