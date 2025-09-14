extends StatePlr

func on_enter() -> void:
	state_duration = 0.2

func process(delta: float)-> void:
	p.velocity.x *= 0.8

	p.slash_handling()
	p.ability_handling(delta)
	
	state_duration = max(state_duration - delta, 0)
	if state_duration <= 0:
		if Global.game_state == Global.GAME_STATES.CUTSCENE:
			p.sm.change_state("cutscene")
		else:
			p.sm.change_state("walk")
	
	p.dash_handling()
	
	if (Input.is_action_just_pressed("jump") or p.next_buffered_state == "jump") and p.is_on_floor():
		p.sm.change_state("jump")

func on_exit()-> void:
	pass
