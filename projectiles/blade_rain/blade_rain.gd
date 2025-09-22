extends Projectile
class_name BladeRain

var blade_x_pos : float

const MAX_AMNT : int = 20

func _ready() -> void:
	pass

const blade_scn : PackedScene = preload("res://projectiles/blade/blade.tscn")
func _spawn_blade() -> void:
	%shing.pitch_scale = randf_range(0.9, 1.1)
	%shing.play()
	blade_x_pos = randf_range(-200, 200)
	
	var blade : Blade = blade_scn.instantiate()
	
	blade.global_position = global_position
	blade.global_position.x += blade_x_pos
	Global.game.add_child(blade)

func _on_spawn_timer_timeout() -> void:
	_spawn_blade()

func _on_life_timer_timeout() -> void:
	queue_free()
