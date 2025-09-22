extends Node2D

func _ready() -> void:
	Global.game_state = Global.GAME_STATES.MAIN
	get_tree().paused = false
	
	Global.boss_alive = false
	Global.game = self
	
	%SpawnBossArea.BossStart.connect(_start_boss)
	%deathbox.attack.damage = 999

func _save() -> void:
	SaveLoad.SaveFileData.bosses_beaten = Global.bosses_beaten
	
	SaveLoad._save()

func _process(delta: float) -> void:
	%boss_gate.enabled = Global.boss_alive

func _on_exit_area_area_entered(area: Area2D) -> void:
	if area.name == "exit_area":
		if Global.bosses_beaten == 2:
			Global.bosses_beaten = 3
			_save()

func _start_boss() -> void:
	%music.play()

func _dead_boss(b3: Boss3) -> void:
	b3.DeadBoss.connect(_stop_music)

func _stop_music() -> void:
	%music.stop()
