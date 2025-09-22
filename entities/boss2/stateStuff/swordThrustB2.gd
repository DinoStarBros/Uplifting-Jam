extends StateBoss2

var dash_startup : float = 0
var dir_to_plr : Vector2

func on_enter() -> void:
	state_duration = 1
	p.anim.play("sword_thrust")
	dash_startup = 0
	
	dir_to_plr = p.global_position.direction_to(Global.player.global_position)

func process(delta: float) -> void:
	
	state_duration = max(state_duration-delta, 0)
	if state_duration <= 0:
		p.sm.change_state("walk")
	
	dash_startup += delta
	if dash_startup >= 0.5:
		p.velocity.x = dir_to_plr.x * 1000 

func on_exit()-> void:
	pass
