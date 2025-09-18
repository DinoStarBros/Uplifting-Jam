extends Node

var master_volume : float = 0.75
var music_volume : float = 0.75
var sfx_volume : float = 0.75
var screen_shake_value : bool 
var frame_freeze_value : bool
var resolution_index : int

var game : Node2D
var cam : Cam
var player : Player
var abilities_inv : AbilitiesInventory
var focused_node : Node
var first_time_boot : bool = true

var equipped_abilities : Array = [
	
]

var glitch_intro_happened : bool = false

const GRAVITY : float = 980
const GRAVITY_LIMIT : float = 2000

enum GAME_STATES {
	TITLE, MAIN, INVENTORY, CUTSCENE
}
var game_state : GAME_STATES

func _init() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	volume_handle()

func _process(delta: float) -> void:
	volume_handle()
	focused_node = get_viewport().gui_get_focus_owner()

func frame_freeze(timescale: float, duration: float) -> void: ## Slows down the engine's time scale, slowing down the time, for a certain duration. Use for da juice
	if frame_freeze_value:
		Engine.time_scale = timescale
		await get_tree().create_timer(duration, true, false, true).timeout
		Engine.time_scale = 1.0

func volume_handle() -> void:
	AudioServer.set_bus_volume_db(
		0,
		linear_to_db(master_volume)
	)
	AudioServer.set_bus_volume_db(
		1,
		linear_to_db(music_volume)
	)
	AudioServer.set_bus_volume_db(
		2,
		linear_to_db(sfx_volume)
	)

var txt_scn : PackedScene = References.juices["splash_txt"]
func spawn_txt(text: Variant, global_pos: Vector2, duration: float = 0.5)->void: ## Spawns a splash text effect, can be used for damage numbers, or score
	var txt : SplashTXT = txt_scn.instantiate()
	txt.duration = duration
	txt.text = str(text)
	txt.global_position = global_pos
	game.add_child(txt)

func change_scene(scene: String) -> void:
	SceneManager.change_scene(
		scene,
	)

var tween : Tween
var property_tween : Object
var tween_ease : Object
func create_property_vec2_tween(
	node:Node,
	vec2:Vector2, 
	property: String = "position",
	time: float = 1.0,
	set_ease: Tween.EaseType = Tween.EASE_IN_OUT, 
	set_trans: Tween.TransitionType = Tween.TRANS_SPRING
	) -> void:
	
	if tween:
		tween.kill()
	
	tween = create_tween()
	property_tween = tween.tween_property(node, property, vec2, time)
	tween_ease = property_tween.set_ease(set_ease)
	tween_ease.set_trans(set_trans)
