extends StateBoss3

func on_enter() -> void:
	p.velocity = Vector2.ZERO
	state_duration = 2
	GlobalSignals.cutscene_start.emit()

func process(delta: float) -> void:
	state_duration = max(state_duration - delta, 0)
	
	if state_duration <= 0:
		GlobalSignals.cutscene_end.emit()
		p.sm.change_state("walk")


func on_exit()-> void:
	pass
