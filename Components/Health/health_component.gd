extends Node2D
class_name HealthComponent

@export var max_hp : float = 10
@export var dmg_txt : bool = true
@export var hp_bar : ProgressBar
@export var hp_txt : Label
var hp : float

func _ready() -> void:
	hp = max_hp
	hp_visuals()

func took_damage(attack : Attack) -> void:
	if dmg_txt:
		Global.spawn_txt(str(roundi(attack.damage)), global_position)

func _process(delta: float) -> void:
	hp_visuals()

func hp_visuals() -> void:
	if hp_bar:
		hp_bar.max_value = max_hp
		hp_bar.value = hp
	
	if hp_txt:
		hp_txt.text = str(
			"HP: ",
			roundi(hp),
			" / ",
			roundi(max_hp)
		)
