extends Node
class_name TitleScreen

@export var speed_up_glitch : bool = false ## For testing purposes

@onready var animation: AnimationPlayer = %animation
@onready var loading_bar: ProgressBar = %loading
@onready var app_icons: AppIcons = %AppIcons
@onready var app_windows: AppWindows = %AppWindows
@onready var taskbar: Control = %Taskbar

var loading_done : bool = false
var loading_txt_dots : Array = [
	"Loading.",
	"Loading..",
	"Loading...",
	"Loading....",
	"Loading.....",
	"Loading......",
]
var loading_bar_tick_values : Array
enum APPS {
	NULL, JOY_ART, INVENTORY
}
var app_opened : APPS = APPS.NULL

func _ready() -> void:
	_load()
	SceneManager.fade_in()
	
	get_tree().paused = false
	Global.game_state = Global.GAME_STATES.TITLE
	
	%play.grab_focus()
	
	%play.pressed.connect(_play_pressed)
	%options.pressed.connect(_options_pressed)
	%quit.pressed.connect(_quit_pressed)
	
	if Global.first_time_boot:
		%animation.play("start")
		Global.first_time_boot = false
		loading_done = false
	else:
		loading_done = true
	
	if speed_up_glitch:
		animation.speed_scale = 10

var lDotsIdx : int = 0
func _process(delta: float) -> void:
	loading_bar.value = wrapf(loading_bar.value + delta, 0, 1)
	
	app_icons.visible = loading_done
	app_windows.visible = loading_done
	taskbar.visible = loading_done

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("M1"):
		if app_opened == APPS.NULL:
			%mClick2.play(0.16)

func _play_pressed() -> void:
	Global.change_scene(References.screen_scenes["main"])
	%mClick2.play(0.16)
	for button in %buttons.get_children():
		button.hide()

func _options_pressed() -> void:
	%mClick2.play(0.16)

func _quit_pressed() -> void:
	%mClick2.play(0.16)
	get_tree().quit()

func _first_time_boot() -> void:
	Global.first_time_boot = false

func _loading_done() -> void:
	loading_done = true

func _on_l_dots_timer_timeout() -> void:
	lDotsIdx = wrapi(lDotsIdx + 1, 0, 5)
	%lDots.text = str(loading_txt_dots[lDotsIdx])

func _switch_scene() -> void:
	get_tree().change_scene_to_file("res://screens/black/black.tscn")
	Global.glitch_intro_happened = true
	_save()

func _load() -> void:
	SaveLoad._load()
	Global.glitch_intro_happened = SaveLoad.SaveFileData.glitch_intro_happened

func _save() -> void:
	SaveLoad.SaveFileData.glitch_intro_happened = Global.glitch_intro_happened
	SaveLoad._save()
