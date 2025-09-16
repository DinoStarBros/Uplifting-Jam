extends Control
class_name JoyArt

@onready var p : TitleScreen = owner

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_x_pressed() -> void:
	_quit()

func _quit() -> void:
	p.app_opened = p.APPS.NULL
