extends StatePlr


func on_enter()-> void:
	state_duration = 0.25
	call_deferred("play_anim_iframe")

func process(delta: float)-> void:
	state_duration = max(state_duration - delta, 0)
	p.velocity *= 0.9
	if state_duration <= 0:
		p.sm.change_state("walk")

func on_exit()-> void:
	pass

func play_anim_iframe() -> void:
	%iframeNim.play("iframed")
