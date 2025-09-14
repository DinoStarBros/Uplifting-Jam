extends Control
class_name Settings

func _ready() -> void:
	
	_on_load_pressed()
	
	#_update_res()
	#_update_vol_val()
	
	%master_volume.value_changed.connect(_on_master_volume_value_changed)
	%music_volume.value_changed.connect(_on_music_volume_value_changed)
	%sfx_vol.value_changed.connect(_on_sfx_vol_value_changed)

	%reset_button.pressed.connect(_reset_sure_press)
	%reset_button_sure.pressed.connect(_on_reset_pressed)

func _on_save_pressed()->void:
	SaveLoad.SaveFileData.master_volume = Global.master_volume
	SaveLoad.SaveFileData.music_volume = Global.music_volume
	SaveLoad.SaveFileData.sfx_volume = Global.sfx_volume
	
	SaveLoad.SaveFileData.screen_shake = Global.screen_shake_value
	SaveLoad.SaveFileData.frame_freeze = Global.frame_freeze_value
	
	#SaveLoad.SaveFileData.resolutuion_index = Global.resolution_index
	SaveLoad._save()

func _on_load_pressed()->void:
	SaveLoad._load()
	_update_res()
	_update_vol_val()

func _on_reset_pressed()->void:
	SaveLoad._reset_save_file()
	SaveLoad._load()
	_update_res()
	_update_vol_val()
	SceneManager.change_scene(References.screen_scenes["title"])

func _update_vol_val()->void:
	Global.master_volume = SaveLoad.SaveFileData.master_volume
	%master_volume.value = Global.master_volume
	
	Global.music_volume = SaveLoad.SaveFileData.music_volume
	%music_volume.value = Global.music_volume
	
	Global.sfx_volume = SaveLoad.SaveFileData.sfx_volume
	%sfx_vol.value = Global.sfx_volume
	
	Global.screen_shake_value = SaveLoad.SaveFileData.screen_shake
	if Global.screen_shake_value:
		%screen_shake.text = str("On")
	else:
		%screen_shake.text = str("Off")
	
	Global.frame_freeze_value = SaveLoad.SaveFileData.frame_freeze
	if Global.frame_freeze_value:
		%frame_freeze.text = str("On")
	else:
		%frame_freeze.text = str("Off")

func _update_res()->void:
	%resOptions.select(SaveLoad.SaveFileData.resolutuion_index)
	_on_res_options_item_selected(SaveLoad.SaveFileData.resolutuion_index)

func _on_master_volume_value_changed(value: float)->void:
	Global.master_volume = value
	

func _on_music_volume_value_changed(value: float)->void:
	Global.music_volume = value
	

func _on_sfx_vol_value_changed(value: float)->void:
	Global.sfx_volume = value
	


func _on_res_options_item_selected(index: int) -> void:
	pass
	#Global.resolution_index = index
	#DisplayServer.window_set_size(resolutions[index])

var resolutions : Array[Vector2i] = [
	Vector2i(1920, 1080),
	Vector2i(1600, 900),
	Vector2i(1280, 720),
]

func _on_back_pressed() -> void:
	_on_save_pressed()
	hide()
	get_tree().paused = false

func _on_frame_freeze_pressed() -> void:
	Global.frame_freeze_value = not Global.frame_freeze_value
	%button_pressed.pitch_scale = randf_range(1.8,2.2)
	%button_pressed.play()
	
	if Global.frame_freeze_value:
		%frame_freeze.text = str("On")
	else:
		%frame_freeze.text = str("Off")


func _on_screen_shake_pressed() -> void:
	Global.screen_shake_value = not Global.screen_shake_value
	%button_pressed.pitch_scale = randf_range(1.8,2.2)
	%button_pressed.play()
	
	if Global.screen_shake_value:
		%screen_shake.text = str("On")
	else:
		%screen_shake.text = str("Off")

func _reset_sure_press() -> void:
	%reset_button_sure.visible = !%reset_button_sure.visible
