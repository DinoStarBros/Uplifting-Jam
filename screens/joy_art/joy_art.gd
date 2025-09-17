extends Control
class_name JoyArt

@export var draw_offset : Vector2

@onready var p : TitleScreen = owner
@onready var line: Line2D = %Line2D
@onready var error_popups: Control = %error_popups

var drawing_started : bool = false
var _pressed : bool = false
var _current_line : Line2D = null
var mouse_in_window : bool = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	if not p.app_opened == p.APPS.JOY_ART:
		drawing_started = false
		%draw.stop()
		return
	
	if Input.is_action_just_pressed("M1") and mouse_in_window:
		%draw.play(5)
		drawing_started = true
	
	if Input.is_action_just_released("M1"):
		%draw.stop()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("unlock_skill"):
		_spawn_error_popup()
	
	if not p.app_opened == p.APPS.JOY_ART:
		for n in %Line2D.get_children():
			n.queue_free()
		
		return
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_pressed = event.pressed
			
			if _pressed and mouse_in_window:
				_current_line = Line2D.new()
				_current_line.default_color = Color.BLACK
				_current_line.width = 4
				line.add_child(_current_line)
				
				_current_line.add_point(event.position + draw_offset)
	
	elif event is InputEventMouseMotion and _pressed and mouse_in_window:
		_current_line.add_point(event.position + draw_offset)

func _on_x_pressed() -> void:
	_quit()

func _quit() -> void:
	p.app_opened = p.APPS.NULL

func _on_window_mouse_entered() -> void:
	mouse_in_window = true

func _on_window_mouse_exited() -> void:
	mouse_in_window = false

var error_popup_scn : PackedScene = preload("res://juices/error_popup/error_popup.tscn")
func _spawn_error_popup() -> void:
	var error_popup : ErrorPopup = error_popup_scn.instantiate()
	
	error_popup.global_position.x = randf_range(50, 700)
	error_popup.global_position.y = randf_range(25, 300)
	error_popups.add_child(error_popup)
