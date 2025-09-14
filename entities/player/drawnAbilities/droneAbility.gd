extends StatePlr

func on_enter() -> void:
	state_duration = 0.2
	_spawn_drone()
	
	p.anim.play("draw_up")
	
	p.enable_gravity = false

func process(delta: float)-> void:
	p.velocity *= 0.9
	
	state_duration = max(state_duration - delta, 0)
	if state_duration <= 0:
		if not p.is_on_floor():
			p.sm.change_state("walk")
		else:
			p.sm.change_state("fall")

func on_exit()-> void:
	pass

var drone_scn : PackedScene = References.projectiles["drone"]
func _spawn_drone() -> void:
	var drone : Drone = drone_scn.instantiate()
	drone.stats = References.statRes["drone"]
	drone.parent = p
	drone.global_position = p.global_position
	Global.game.add_child(drone)
