extends StatePlr

func on_enter()-> void:
	state_duration = 0.8
	%heal_start.play()

func process(delta: float)-> void:
	
	p.velocity.x *= 0.8
	p.velocity.y = 0
	
	state_duration = max(state_duration - delta, 0)
	if state_duration <= 0:
		
		
		%heal.play()
		Global.spawn_txt("+10", p.global_position)
		p.health_component.hp += 10
		if p.health_component.hp >= p.health_component.max_hp:
			p.health_component.hp = p.health_component.max_hp
		if not p.is_on_floor():
			p.sm.change_state("walk")
		else:
			p.sm.change_state("fall")

func on_exit()-> void:
	pass
