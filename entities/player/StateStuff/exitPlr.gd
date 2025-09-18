extends StatePlr

func on_enter() -> void:
	state_duration = 3
	p.velocity.x = 0
	p.override_flip_sprite = true

func process(delta: float) -> void:
	state_duration = max(state_duration - delta, 0)
	if state_duration <= 0:
		Global.change_scene("res://screens/title_screen/title_screen.tscn")

func on_exit()-> void:
	pass
