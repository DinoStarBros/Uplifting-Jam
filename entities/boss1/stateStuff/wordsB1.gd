extends StateBoss1

func on_enter() -> void:
	state_duration = 2
	p.anim.play("words")
	
	Global.cam.screen_shake(20, 0.5)

func process(delta: float) -> void:
	state_duration = max(state_duration-delta, 0)
	if state_duration <= 0:
		p.sm.change_state("walk")

func on_exit()-> void:
	pass
