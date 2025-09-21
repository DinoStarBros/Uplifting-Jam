extends Node2D

func _ready() -> void:
	Global.game_state = Global.GAME_STATES.MAIN
	get_tree().paused = false
	
	Global.game = self

func _save() -> void:
	SaveLoad.SaveFileData.bosses_beaten = Global.bosses_beaten
	
	SaveLoad._save()

func _process(delta: float) -> void:
	%boss_gate.enabled = Global.boss_alive

func _on_exit_area_area_entered(area: Area2D) -> void:
	if area.name == "exit_area":
		if Global.bosses_beaten == 0:
			Global.bosses_beaten = 1
			_save()
