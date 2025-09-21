extends StateBoss1

var just_on_floor : bool = true

func on_enter() -> void:
	p.velocity = Vector2.ZERO
	state_duration = 2
	%falling.play()

func process(delta: float) -> void:
	state_duration = max(state_duration - delta, 0)
	
	if state_duration <= 0:
		GlobalSignals.cutscene_end.emit()
		p.sm.change_state("walk")
	
	if p.is_on_floor() and just_on_floor:
		Global.cam.screen_shake(20, 0.2)
		%gswave.play(0.13)
		%falling.stop()
		just_on_floor = false

func on_exit()-> void:
	pass
