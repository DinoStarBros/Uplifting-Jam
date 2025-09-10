extends StatePlr

func _ready() -> void:
	%dashTimer.timeout.connect(_dash_timeout)

func on_enter()-> void:
	p.anim.play("dash")
	p.velocity.x = p.DASH_SPEED * p.last_x_input
	%dashTimer.start(p.DASH_DURATION)
	p.velocity.y = 0
	p.enable_gravity = false
	p.override_flip_sprite = true
	%dash_sfx.pitch_scale = randf_range(1.2, 1.5)
	%dash_sfx.play()
	
	p.air_dashes -= 1

func process(delta: float)-> void:
	p.velocity.y = 0

func on_exit()-> void:
	pass

func _dash_timeout() -> void:
	p.sm.change_state("walk")
