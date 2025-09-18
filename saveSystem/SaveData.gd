extends Resource
class_name SaveDataResource

@export var master_volume : float = 0.75
@export var music_volume : float = 0.75
@export var sfx_volume : float = 0.75

@export var resolutuion_index : int = 2

@export var screen_shake : bool = true
@export var frame_freeze : bool = true

@export var switch_acc_roll : bool = false 
@export var language_idx : int = 0 ## English = 0

@export var equipped_abilities : Array = [
	"minigun",
	"pistol",
	"fist"
]

@export var skills_unlockeds : Array = [
	true,
	false,
	false
	
]

@export var glitch_intro_happened: bool = false

@export var bosses_beaten : int = 0
@export var inspiration : int = 0
