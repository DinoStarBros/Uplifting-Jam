extends Button

### VERY IMPORTANT: The node's name has to be the same as the 
### ability's state name

var abilities_inv : AbilitiesInventory

func _ready() -> void:
	pressed.connect(_pressed_button)
	await get_tree().process_frame
	abilities_inv = Global.abilities_inv

func _pressed_button() -> void:
	abilities_inv.ability_button_pressed(name)
