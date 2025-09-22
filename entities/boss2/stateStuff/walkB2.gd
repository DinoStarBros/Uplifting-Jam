extends StateBoss2

var next_attack_idx : int = 0

var x_walk_dir : int = 0

func on_enter() -> void:
	state_duration = randf_range(0.5,1)
	next_attack_idx = p.attack_frequencies[p.current_attack_idx]
	p.current_attack_idx += 1
	if p.current_attack_idx >= p.attack_frequencies.size():
		p.current_attack_idx = 0
	
	x_walk_dir = randi_range(-1, 1)
	p.velocity.x = x_walk_dir * p.SPEED

func process(delta: float) -> void:
	
	state_duration = max(state_duration-delta, 0)
	if state_duration <= 0:
		next_atk(next_attack_idx)

func on_exit()-> void:
	p.velocity.x =0 

func next_atk(idx: int) -> void:
	match idx:
		0:
			p.sm.change_state("sword_thrust")
			
		1:
			p.sm.change_state("dagger_throw")
			
		2:
			p.sm.change_state("jump_dagger_throw")
			
		3:
			p.sm.change_state("slash_line")
