extends StatePlr

func on_enter() -> void:
	state_duration = 3
	p.velocity.x = 0
	p.override_flip_sprite = true

func process(delta: float) -> void:
	state_duration = max(state_duration - delta, 0)
	if state_duration <= 0:
		p.sm.change_state("walk")
		p.scene_just_started = false

func on_exit()-> void:
	pass
