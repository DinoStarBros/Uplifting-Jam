extends Node2D

func _ready() -> void:
	Global.game_state = Global.GAME_STATES.MAIN
	get_tree().paused = false
	
	Global.game = self

func _on_exit_area_area_entered(area: Area2D) -> void:
	if area.name == "exit_area":
		if Global.bosses_beaten == 2:
			Global.bosses_beaten = 3
			_save()

func _save() -> void:
	SaveLoad.SaveFileData.bosses_beaten = Global.bosses_beaten
	
	SaveLoad._save()
