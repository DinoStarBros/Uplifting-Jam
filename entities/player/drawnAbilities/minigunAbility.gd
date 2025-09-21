extends StatePlr

func on_enter()-> void:
	state_duration = 0.3
	_spawn_pistol()
	p.anim.play("draw_side")
	p.velocity.x = -p.last_x_input * 500

func process(delta: float) -> void:
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

var minigun_scn : PackedScene = References.projectiles["minigun"]
func _spawn_pistol() -> void:
	
	var mg : Minigun = minigun_scn.instantiate()
	
	mg.stats = References.statRes["minigun"]
	
	mg.global_position = p.global_position
	mg.global_position.x += 35 * p.last_x_input
	mg.dir = Vector2(p.last_x_input, 0)
	Global.game.add_child(mg)
