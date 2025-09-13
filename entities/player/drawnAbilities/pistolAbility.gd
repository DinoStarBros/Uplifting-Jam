extends StatePlr

func on_enter()-> void:
	state_duration = 0.3
	_spawn_pistol()
	
	p.anim.play("draw_side")

func process(delta: float)-> void:
	
	p.velocity.x *= 0.8
	p.velocity.y = 0
	
	state_duration = max(state_duration - delta, 0)
	if state_duration <= 0:
		if not p.is_on_floor():
			p.sm.change_state("walk")
		else:
			p.sm.change_state("fall")

func on_exit()-> void:
	pass

var pistol_scn : PackedScene = References.projectiles["pistol"]
func _spawn_pistol() -> void:
	
	var pistol : Pistol = pistol_scn.instantiate()
	
	pistol.global_position = p.global_position
	pistol.global_position.x += 35 * p.last_x_input
	pistol.dir = Vector2(p.last_x_input, 0)
	Global.game.add_child(pistol)
