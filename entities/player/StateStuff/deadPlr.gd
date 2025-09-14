extends StatePlr

var scene_switched : bool = false

func on_enter()-> void:
	state_duration = 1
	await get_tree().process_frame
	scene_switched = false
	p.hurtbox_component.collision_shape.disabled = true

func process(delta: float)-> void:
	state_duration = max(state_duration - delta, 0)
	p.velocity *= 0.9
	p.override_flip_sprite = true
	p.enable_gravity = false
	
	if state_duration <= 0:
		if not scene_switched:
			Global.change_scene("res://screens/title_screen/title_screen.tscn")
			scene_switched = true

func on_exit()-> void:
	pass
