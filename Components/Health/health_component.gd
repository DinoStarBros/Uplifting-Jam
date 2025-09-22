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

var just_75: bool = false
var just_50 : bool= false
var just_25: bool= false
func took_damage(attack : Attack) -> void:
	if dmg_txt:
		Global.spawn_txt(str(roundi(attack.damage)), global_position)
	
	var hp_75 : float = max_hp * 0.75
	var hp_50 : float = max_hp * 0.50
	var hp_25 : float = max_hp * 0.25
	
	if get_parent().is_in_group("Boss"):
		if hp <= hp_75 and not just_75:
			%shving.play()
			just_75 = true
			Global.inspiration += 1
			Global.spawn_txt("Inspiration +1!", global_position)
			_save()
		
		if hp <= hp_50 and not just_50:
			%shving.play()
			just_50 = true
			Global.inspiration += 1
			Global.spawn_txt("Inspiration +1!", global_position)
			_save()
		
		if hp <= hp_25 and not just_25:
			%shving.play()
			just_25 = true
			Global.inspiration += 1
			Global.spawn_txt("Inspiration +1!", global_position)
			_save()

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

func _save() -> void:
	SaveLoad.SaveFileData.inspiration = Global.inspiration
	
	SaveLoad._save()
