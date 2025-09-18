extends CanvasLayer
class_name GUI

@onready var pause: Control = %pause
@onready var settings_menu: Settings = %settingsMenu

var sure_quit : bool = false
var gui_mode : GUI_MODES = GUI_MODES.UNPAUSED

enum GUI_MODES {
	UNPAUSED ,INVENTORY, PAUSE
}

func _ready() -> void:
	%resume.pressed.connect(_resume_pressed)
	%sure.pressed.connect(_sure_pressed)
	%quit.pressed.connect(_quit_pressed)
	
	GlobalSignals.cutscene_start.connect(_cutscene_start)
	GlobalSignals.cutscene_end.connect(_cutscene_end)

func _process(_delta: float) -> void:
	pause.visible = (
		get_tree().paused 
		and Global.game_state == Global.GAME_STATES.MAIN 
		and gui_mode == GUI_MODES.PAUSE
	)
	%sure.visible = sure_quit
	
	if Input.is_action_just_pressed("Esc"):
		_pause()
	
	if Input.is_action_just_pressed("unlock_skill"):
		GlobalSignals.cutscene_end.emit()

func _pause() -> void:
	if not Global.game_state == Global.GAME_STATES.MAIN:
		return
	
	if not(gui_mode == GUI_MODES.UNPAUSED or gui_mode == GUI_MODES.PAUSE):
		return
	
	get_tree().paused = not get_tree().paused
	sure_quit = false
	
	if get_tree().paused:
		settings_menu._on_load_pressed()
		gui_mode = GUI_MODES.PAUSE
		%resume.grab_focus()
	else:
		settings_menu._on_save_pressed()
		gui_mode = GUI_MODES.UNPAUSED

func _resume_pressed() -> void:
	_pause()

func _sure_pressed() -> void:
	Global.change_scene(References.screen_scenes["title"])

func _quit_pressed() -> void:
	sure_quit = not sure_quit


func _cutscene_start() -> void:
	%black_bars.show()
	Global.create_property_vec2_tween(%black_bars, Vector2.ONE, "scale", 1,)
	Global.game_state = Global.GAME_STATES.CUTSCENE

func _cutscene_end() -> void:
	Global.create_property_vec2_tween(%black_bars, Vector2(1.5, 1.5), "scale",)
	Global.game_state = Global.GAME_STATES.MAIN
