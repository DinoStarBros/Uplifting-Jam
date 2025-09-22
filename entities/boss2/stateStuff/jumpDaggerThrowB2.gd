extends StateBoss2

var dir_to_plr : Vector2

func on_enter() -> void:
	state_duration = 2
	p.anim.play("jump_dagger")
	p.velocity.y = -p.JUMP_VELOCITY
	
	dir_to_plr = p.global_position.direction_to(Global.player.global_position)

func process(delta: float) -> void:
	if p.is_on_floor():
		p.velocity.x = 0
	else:
		p.velocity.x = dir_to_plr.x * p.SPEED
	
	state_duration = max(state_duration-delta, 0)
	if state_duration <= 0:
		p.sm.change_state("walk")
	

func on_exit()-> void:
	pass
