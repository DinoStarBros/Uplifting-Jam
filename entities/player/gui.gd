extends CanvasLayer
class_name GUI

@onready var pause: Control = %pause

var sure_quit : bool = false

func _ready() -> void:
	%resume.pressed.connect(_resume_pressed)
	%sure.pressed.connect(_sure_pressed)
	%quit.pressed.connect(_quit_pressed)

func _process(_delta: float) -> void:
	%pause.visible = get_tree().paused
	%sure.visible = sure_quit

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Esc"):
		_pause()

func _pause() -> void:
	if Global.game_state != Global.GAME_STATES.MAIN:
		return
	
	get_tree().paused = not get_tree().paused
	sure_quit = false

func _resume_pressed() -> void:
	get_tree().paused = false

func _sure_pressed() -> void:
	Global.change_scene(References.screen_scenes["title"])

func _quit_pressed() -> void:
	sure_quit = not sure_quit
