extends StatePlr

func on_enter()-> void:
	state_duration = 0.3
	_spawn_pistol()
	p.anim.play("draw_side")
	p.velocity.x = -p.last_x_input * 500

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

var pistol_scn : PackedScene = preload("res://projectiles/sword/sword.tscn")
func _spawn_pistol() -> void:
	
	var pistol : Sword = pistol_scn.instantiate()
	
	pistol.global_position = p.global_position
	pistol.global_position.x += 35 * p.last_x_input
	Global.game.add_child(pistol)
