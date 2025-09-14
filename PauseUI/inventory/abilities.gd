extends Control
class_name AbilitiesInventory

@onready var a1: Button = %a1
@onready var a2: Button = %a2
@onready var a3: Button = %a3
@onready var all_abilities: GridContainer = %all_abilities

var which_equipping : int = false
var ability_handler : Ability_Handler
var equipped_abilities : Array

func _ready() -> void:
	a1.pressed.connect(_a1_press)
	a2.pressed.connect(_a2_press)
	a3.pressed.connect(_a3_press)
	
	Global.abilities_inv = self

func on_pause() -> void:
	_load_ability_data()
	which_equipping = 0

func on_resume() -> void:
	_save_ability_data()

func _a1_press() -> void:
	if which_equipping == 0:
		which_equipping = 1
		%minigun.grab_focus()
	elif which_equipping == 1:
		which_equipping = 0

func _a2_press() -> void:
	if which_equipping == 0:
		which_equipping = 2
		%minigun.grab_focus()
	elif which_equipping == 2:
		which_equipping = 0

func _a3_press() -> void:
	if which_equipping == 0:
		which_equipping = 3
		%minigun.grab_focus()
	elif which_equipping == 3:
		which_equipping = 0

func update_ability_visuals() -> void:
	await get_tree().process_frame
	a1.text = str("Neutral / 1: \n", ability_handler.equipped_abilities[0])
	a2.text = str("Up / 2: \n", ability_handler.equipped_abilities[1])
	a3.text = str("Down / 3: \n", ability_handler.equipped_abilities[2])

func _process(delta: float) -> void:
	
	match which_equipping:
		0:
			update_ability_visuals()
		1:
			a1.text = str("Choose a \n drawing")
			a2.text = str("Up / 2: \n", ability_handler.equipped_abilities[1])
			a3.text = str("Down / 3: \n", ability_handler.equipped_abilities[2])
		2:
			a1.text = str("Neutral / 1: \n", ability_handler.equipped_abilities[0])
			a2.text = str("Choose a \n drawing")
			a3.text = str("Down / 3: \n", ability_handler.equipped_abilities[2])
		3:
			a1.text = str("Neutral / 1: \n", ability_handler.equipped_abilities[0])
			a2.text = str("Up / 2: \n", ability_handler.equipped_abilities[1])
			a3.text = str("Choose a \n drawing")
	
	all_abilities.visible = which_equipping != 0

var same_abilities : bool = false
func ability_button_pressed(ability_name: String) -> void:
	var ability : String
	for ab: String in ability_handler.equipped_abilities:
		if ab == ability_name:
			same_abilities = true
			ability = ab
			break
		else:
			same_abilities = false
	
	if same_abilities:
		var idx_with_same : int = ability_handler.equipped_abilities.find(ability)
		# 2 same abilities switch places
		
		ability_handler.equipped_abilities[idx_with_same] = ability_handler.equipped_abilities[which_equipping - 1]
		# The already equipped ability with the same name as the
		# ability that's just getting equipp;ed gets replaced with the original slot
		
		ability_handler.equipped_abilities[which_equipping - 1] = ability_name
		# It then gets assigned the new ability
	else:
		ability_handler.equipped_abilities[which_equipping - 1] = ability_name
	
	a1.grab_focus()
	
	which_equipping = 0

func _save_ability_data() -> void:
	SaveLoad.SaveFileData.equipped_abilities = ability_handler.equipped_abilities
	SaveLoad._save()

func _load_ability_data() -> void:
	SaveLoad._load()
	ability_handler.equipped_abilities = SaveLoad.SaveFileData.equipped_abilities

func _on_reset()->void:
	SaveLoad._reset_save_file()
	SaveLoad._load()
	ability_handler.equipped_abilities = SaveLoad.SaveFileData.equipped_abilities
