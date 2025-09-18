extends Control

@onready var p : TitleScreen = owner
@onready var l_menu: Panel = %lMenu
@onready var settings_menu: Settings = %settingsMenu

var logo_opened : bool = false

func _ready() -> void:
	%x_ja.pressed.connect(_x_ja_press)
	%logo.pressed.connect(_logo_pressed)
	%shutDown.pressed.connect(_shutdown_pressed)
	
	logo_opened = false
	l_menu.visible = logo_opened

func _x_ja_press() -> void:
	p.app_opened = p.APPS.NULL

func _logo_pressed() -> void:
	logo_opened = not logo_opened
	
	l_menu.visible = logo_opened
	_pause()

func _shutdown_pressed() -> void:
	get_tree().quit()

func _pause() -> void:
	
	if logo_opened:
		settings_menu._on_load_pressed()
	else:
		settings_menu._on_save_pressed()
