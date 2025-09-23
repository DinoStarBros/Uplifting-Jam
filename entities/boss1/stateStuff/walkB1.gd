extends StateBoss1

var next_attack_idx : int = 0

func on_enter() -> void:
	state_duration = randf_range(0.5,1)
	next_attack_idx = p.attack_pattern[p.current_attack_idx]
	p.current_attack_idx += 1
	if p.current_attack_idx >= p.attack_pattern.size():
		p.current_attack_idx = 0

func process(delta: float) -> void:
	p.anim.play("idle")
	state_duration = max(state_duration-delta, 0)
	if state_duration <= 0:
		next_atk(next_attack_idx)

func on_exit()-> void:
	pass

func next_atk(idx: int) -> void:
	p.last_attack_id = idx
	match idx:
		0:
			p.sm.change_state("jump")
			
		1:
			p.sm.change_state("words")
			
		2:
			p.sm.change_state("spikes")
			
