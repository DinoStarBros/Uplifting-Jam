extends Control
class_name AppWindows

@onready var inventory_stuff: Inventory = %inventoryStuff
@onready var p : TitleScreen = owner
@onready var joy_art: JoyArt = %joy_art_window

func _process(delta: float) -> void:
	joy_art.visible = p.app_opened == p.APPS.JOY_ART
	inventory_stuff.visible = p.app_opened == p.APPS.INVENTORY

func _quit() -> void:
	p.app_opened = p.APPS.NULL

func _on_x_inv_pressed() -> void:
	_quit()
	inventory_stuff.on_resume()
