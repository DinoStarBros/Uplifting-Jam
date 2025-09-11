extends StatePlr


func on_enter()-> void:
	pass

func process(delta: float)-> void:
	state_duration = max(state_duration-delta, 0)
	if state_duration <= 0:
		p.sm.change_state("walk")

func on_exit()-> void:
	pass
