extends Control
class_name AppIcons

@onready var joy_art: JoyArt = %joy_art_window
@onready var p : TitleScreen = owner

func _on_joy_art_pressed() -> void:
	%mClick2.play(0.16)
	await get_tree().create_timer(randf_range(0.5, 1.2)).timeout
	p.app_opened = p.APPS.JOY_ART

func _process(delta: float) -> void:
	joy_art.visible = p.app_opened == p.APPS.JOY_ART

func _on_drawings_pressed() -> void:
	pass
