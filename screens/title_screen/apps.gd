extends Control
class_name AppIcons

@onready var p : TitleScreen = owner
@onready var app_windows: AppWindows = %AppWindows
@onready var inventory_stuff: Inventory = %inventoryStuff

var show_reset_panel : bool = false
 
func _ready() -> void:
	_load()
	%recycleBin.pressed.connect(_recycleBin_pressed)

func _on_joy_art_pressed() -> void:
	%mClick2.play(0.16)
	await get_tree().create_timer(randf_range(0.5, 1.2)).timeout
	
	p.app_opened = p.APPS.JOY_ART

func _on_drawings_pressed() -> void:
	p.app_opened = p.APPS.INVENTORY
	inventory_stuff.on_pause()

func _process(delta: float) -> void:
	%drawings.visible = Global.glitch_intro_happened
	if Global.glitch_intro_happened:
		%tutorial.visible = Global.bosses_beaten >= 0
		%doubt.visible = Global.bosses_beaten >= 0
		%perfectionism.visible = Global.bosses_beaten >= 1
		%artblock.visible = Global.bosses_beaten >= 2
	else:
		%tutorial.hide()
		%doubt.hide()
		%perfectionism.hide()
		%artblock.hide()

func _on_tutorial_pressed() -> void:
	Global.change_scene("res://screens/main/tutorial.tscn")

func _on_doubt_pressed() -> void:
	Global.change_scene("res://screens/boss1SCN/B1.tscn")

func _on_perfectionism_pressed() -> void:
	Global.change_scene("res://screens/boss2SCN/B2.tscn")

func _on_art_block_pressed() -> void:
	Global.change_scene("res://screens/boss3SCN/B3.tscn")

func _load() -> void:
	SaveLoad._load()
	SaveLoad.SaveFileData.bosses_beaten = Global.bosses_beaten

func _recycleBin_pressed()->void:
	pass

func _reset_savefile() -> void:
	SaveLoad._reset_save_file()
	SaveLoad._load()
	SceneManager.change_scene(References.screen_scenes["title"])
