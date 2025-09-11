extends StatePlr

var drone_spawned : bool = false
func on_enter()-> void:
	state_duration = 0.2
	if not drone_spawned:
		_spawn_drone()
	drone_spawned = true

func process(delta: float)-> void:
	
	state_duration = max(state_duration-delta, 0)
	if state_duration <= 0:
		p.sm.change_state("walk")

func on_exit()-> void:
	pass

var drone_scn : PackedScene = References.projectiles["drone"]
func _spawn_drone() -> void:
	var drone : Drone = drone_scn.instantiate()
	drone.parent = p
	drone.global_position = p.global_position
	Global.game.add_child(drone)
