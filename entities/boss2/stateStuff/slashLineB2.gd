extends StateBoss2

var next_attack_idx : int = 0

func on_enter() -> void:
	p.velocity = Vector2.ZERO
	state_duration = 2
	p.anim.play("slashies")

func process(delta: float) -> void:
	p.velocity = Vector2.ZERO
	
	state_duration = max(state_duration-delta, 0)
	if state_duration <= 0:
		p.sm.change_state("walk")

func on_exit()-> void:
	pass
