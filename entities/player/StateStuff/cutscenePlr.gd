extends StatePlr

func on_enter()-> void:
	p.anim.play("cutscene")

func process(delta: float)-> void:
	p.velocity *= 0.8
	p.override_flip_sprite = true
	
	p.enable_gravity = true

func on_exit()-> void:
	pass
