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
var start_errors : bool = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	if not p.app_opened == p.APPS.JOY_ART:
		start_errors = false
		just_reached_02 = false
		if drawing_started:
			drawing_started = false
		%draw.stop()
		return
	
	if Input.is_action_just_pressed("M1") and mouse_in_window:
		%draw.play(5)
		if not drawing_started:
			drawing_started = true
			if not Global.glitch_intro_happened:
				if p.speed_up_glitch:
					%errorStartTimer.start(0.1)
				else:
					%errorStartTimer.start(5)
	
	if Input.is_action_just_released("M1"):
		%draw.stop()

func _input(event: InputEvent) -> void:
	
	if not p.app_opened == p.APPS.JOY_ART:
		for n in line.get_children():
			n.queue_free()
		
		for m in %error_popups.get_children():
			m.queue_free()
		
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
	%error.play()
	var error_popup : ErrorPopup = error_popup_scn.instantiate()
	
	error_popup.global_position.x = randf_range(-100, 600)
	error_popup.global_position.y = randf_range(25, 300)
	error_popup.p = p
	error_popups.add_child(error_popup)

var error_spawn_interval : float = 5.0
func _on_error_start_timer_timeout() -> void:
	start_errors = true
	if p.speed_up_glitch:
		error_spawn_interval = 1
	
	%errorSpawnTimer.start(error_spawn_interval)

var just_reached_02 : bool = false
func _on_error_spawn_timer_timeout() -> void:
	if start_errors:
		error_spawn_interval -= 0.2
		if error_spawn_interval <= 3:
			error_spawn_interval -= 0.5
		if error_spawn_interval <= 0.2:
			error_spawn_interval = 0.2
			if not just_reached_02:
				just_reached_02 = true
				p.animation.play("glitch_anim")
				
		%errorSpawnTimer.start(error_spawn_interval)
		_spawn_error_popup()
