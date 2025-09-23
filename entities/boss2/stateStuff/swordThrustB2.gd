extends StateBoss2

var dash_startup : float = 0
var dir_to_plr : Vector2

var just_dash : bool = false
func on_enter() -> void:
	state_duration = 2
	p.anim.play("sword_thrust")
	dash_startup = 0
	just_dash = false
	
	dir_to_plr = p.global_position.direction_to(Global.player.global_position)

var dvx : float
func process(delta: float) -> void:
	p.stop_flip = true
	
	state_duration = max(state_duration-delta, 0)
	if state_duration <= 0:
		p.sm.change_state("walk")
		p.stop_flip = false
	
	dash_startup += delta
	if dash_startup >= 0.5 and not just_dash:
		just_dash = true
		if dir_to_plr.x > 0:
			dvx = 1
		else:
			dvx = -1
		
		p.velocity.x = dvx * 2000 
	
	p.velocity.x *= 0.96

func on_exit()-> void:
	pass
