extends StateBoss1

func on_enter() -> void:
	pass

func process(delta: float) -> void:
	p.velocity.x *= 0.8

func on_exit()-> void:
	pass
