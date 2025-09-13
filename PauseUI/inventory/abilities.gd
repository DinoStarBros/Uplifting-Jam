extends Control
class_name AbilitiesInventory

@onready var a1: Button = %a1
@onready var a2: Button = %a2
@onready var a3: Button = %a3

var which_equipping : int = false
var ability_handler : Ability_Handler

func _ready() -> void:
	a1.pressed.connect(_a1_press)
	a2.pressed.connect(_a2_press)
	a3.pressed.connect(_a3_press)

func on_pause() -> void:
	which_equipping = 0

func on_resume() -> void:
	pass

func _a1_press() -> void:
	which_equipping = 1

func _a2_press() -> void:
	which_equipping = 2

func _a3_press() -> void:
	which_equipping = 3

func update_ability_visuals() -> void:
	pass

func _process(delta: float) -> void:
	
	match which_equipping:
		0:
			a1.text = str("A1: \n", ability_handler.equipped_abilities[1])
			a2.text = str("A2: \n", ability_handler.equipped_abilities[0])
			a3.text = str("A3: \n", ability_handler.equipped_abilities[2])
		1:
			a1.text = str("Choose a \n drawing")
			a2.text = str("A2: \n", ability_handler.equipped_abilities[0])
			a3.text = str("A3: \n", ability_handler.equipped_abilities[2])
			which_equipping_1()
		2:
			a1.text = str("A1: \n", ability_handler.equipped_abilities[1])
			a2.text = str("Choose a \n drawing")
			a3.text = str("A3: \n", ability_handler.equipped_abilities[2])
			which_equipping_2()
		3:
			a1.text = str("A1: \n", ability_handler.equipped_abilities[1])
			a2.text = str("A2: \n", ability_handler.equipped_abilities[0])
			a3.text = str("Choose a \n drawing")
			which_equipping_3()

func which_equipping_1() -> void:
	pass


func which_equipping_2() -> void:
	pass


func which_equipping_3() -> void:
	pass
