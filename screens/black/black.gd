extends Polygon2D

func _on_timer_timeout() -> void:
	Global.change_scene("res://screens/main/tutorial.tscn")
