extends Node2D

func _ready() -> void:
	Global.game_state = Global.GAME_STATES.MAIN
	get_tree().paused = false
	
	Global.boss_alive = false
	Global.game = self
	
	%SpawnBossArea.BossStart.connect(_start_boss)

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

func connect_spike_sig(b1: Boss1) -> void:
	b1.EmergeSpikes.connect(_emerge_spikes)

func _emerge_spikes() -> void:
	%spikeNim.play("emerge_spike")

func _start_boss() -> void:
	%music.play()

func _dead_boss(b1: Boss1) -> void:
	b1.DeadBoss.connect(_stop_music)

func _stop_music() -> void:
	%music.stop()
