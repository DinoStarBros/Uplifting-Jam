extends StateBoss2

func on_enter() -> void:
	p.velocity = Vector2.ZERO
	Global.boss_alive = false


func process(delta: float) -> void:
	pass

func on_exit()-> void:
	pass
