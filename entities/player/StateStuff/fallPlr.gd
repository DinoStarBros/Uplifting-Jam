extends StatePlr

func on_enter()-> void:
	p.anim.play("fall")
	p.jump_buffer_time = 0

func process(delta: float)-> void:
	p.velocity.x = p.x_input * p.SPEED
	p.slash_handling()
	
	
	if Input.is_action_pressed("jump"):
		p.jump_buffer_time += delta
	else:
		p.jump_buffer_time = 0
	
	if p.is_on_floor():
		p.sm.change_state("walk")
		
		if p.jump_buffer_time < 0.3 and p.jump_buffer_time > 0:
			p.next_buffered_state = "jump"
		else:
			p.next_buffered_state = "nuh"
	
	if p.coyote_time < p.COYOTE_TIME_THRESHOLD and Input.is_action_just_pressed("jump"):
		p.sm.change_state("jump")
	
	p.dash_handling()

func on_exit()-> void:
	pass
