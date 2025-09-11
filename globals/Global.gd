extends Node

var master_volume : float
var music_volume : float
var sfx_volume : float
var screen_shake_value : bool 
var frame_freeze_value : bool
var resolution_index : int

var game : Node2D
var cam : Cam

const GRAVITY : float = 980

enum GAME_STATES {
	TITLE, MAIN, INVENTORY
}
var game_state : GAME_STATES

func _init() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	volume_handle()

func _process(delta: float) -> void:
	volume_handle()

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
