extends Control
class_name AppIcons

@onready var p : TitleScreen = owner
@onready var app_windows: AppWindows = %AppWindows
@onready var inventory_stuff: Inventory = %inventoryStuff

func _on_joy_art_pressed() -> void:
	%mClick2.play(0.16)
	await get_tree().create_timer(randf_range(0.5, 1.2)).timeout
	
	p.app_opened = p.APPS.JOY_ART

func _on_drawings_pressed() -> void:
	p.app_opened = p.APPS.INVENTORY
	inventory_stuff.on_pause()
