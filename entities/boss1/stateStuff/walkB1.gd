extends StateBoss1

var next_attack_idx : int = 0

func on_enter() -> void:
	state_duration = randf_range(1.5,3)
	next_attack_idx = 0#randi_range(0,2)

func process(delta: float) -> void:
	p.velocity.x *= 0.8
	
	state_duration = max(state_duration-delta, 0)
	if state_duration <= 0:
		next_atk(next_attack_idx)

func on_exit()-> void:
	pass

func next_atk(idx: int) -> void:
	match idx:
		0:
			p.sm.change_state("jump")
			
		1:
			p.sm.change_state("bash")
			
		2:
			p.sm.change_state("ram")
			
