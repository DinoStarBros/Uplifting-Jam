extends Control
class_name Inventory

@onready var abilities_inv: AbilitiesInventory = %Abilities
@onready var skill_tree: SkillTree = %SkillTree

func _ready() -> void:
	await get_tree().process_frame

func _process(delta: float) -> void:
	%insp.text = str("Inspiration: ", Global.inspiration)
	
	for n in %all_abilities.get_children().size():
		%all_abilities.get_children()[n].visible = skill_tree.skills_unlockeds[n + 1]

func on_pause() -> void:
	abilities_inv.on_pause()
	skill_tree.on_pause()
	abilities_inv.update_ability_visuals()

func on_resume() -> void:
	abilities_inv.on_resume()
	skill_tree.on_resume()
