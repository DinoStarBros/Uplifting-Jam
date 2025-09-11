extends StatePlr


func on_enter()-> void:
	state_duration = 0.3

func process(delta: float)-> void:
	state_duration = max(state_duration - delta, 0)
	p.velocity *= 0.9
	if state_duration <= 0:
		p.sm.change_state("walk")

func on_exit()-> void:
	pass
