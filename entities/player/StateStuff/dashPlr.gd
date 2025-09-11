extends StatePlr

func _ready() -> void:
	pass

func on_enter()-> void:
	p.anim.play("dash")
	p.velocity.x = p.DASH_SPEED * p.last_x_input
	p.velocity.y = 0
	p.enable_gravity = false
	p.override_flip_sprite = true
	%dash_sfx.pitch_scale = randf_range(1.2, 1.5)
	%dash_sfx.play()
	
	p.air_dashes -= 1
	
	state_duration = p.DASH_DURATION

func process(delta: float)-> void:
	state_duration = max(state_duration - delta, 0)
	p.velocity.y = 0
	if state_duration <= 0:
		p.sm.change_state("walk")
	


func on_exit()-> void:
	pass
