extends StateBoss3

var next_attack_idx : int = 0

func on_enter() -> void:
	state_duration = 1
	p.anim.play("summon")

func process(delta: float) -> void:
	
	p._spawn_fire(0)
	
	state_duration = max(state_duration-delta, 0)
	if state_duration <= 0:
		p.sm.change_state("walk")

func on_exit()-> void:
	pass
