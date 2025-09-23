extends Node2D
class_name Tutorial

func _ready() -> void:
	Global.game_state = Global.GAME_STATES.MAIN
	get_tree().paused = false
	
	Global.game = self
	SceneManager.fade_in()

func _on_exit_area_body_entered(body: Node2D) -> void:
	if body is Player:
		if Global.bosses_beaten == 0:
			Global.bosses_beaten = 0
			_save()

func _save() -> void:
	SaveLoad.SaveFileData.bosses_beaten = Global.bosses_beaten
	
	SaveLoad._save()
