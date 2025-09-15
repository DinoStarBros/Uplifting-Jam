extends Node
class_name TitleScreen

@onready var animation: AnimationPlayer = %animation

func _ready() -> void:
	SceneManager.fade_in()
	
	get_tree().paused = false
	Global.game_state = Global.GAME_STATES.TITLE
	
	%play.grab_focus()
	
	%play.pressed.connect(_play_pressed)
	%options.pressed.connect(_options_pressed)
	%quit.pressed.connect(_quit_pressed)
	

func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	pass

func _play_pressed() -> void:
	Global.change_scene(References.screen_scenes["main"])
	for button in %buttons.get_children():
		button.hide()

func _options_pressed() -> void:
	pass

func _quit_pressed() -> void:
	get_tree().quit()

func _first_time_boot() -> void:
	Global.first_time_boot = false
