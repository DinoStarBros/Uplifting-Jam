extends Control
class_name Inventory

@onready var abilities_inv: AbilitiesInventory = %Abilities
@onready var skill_tree: SkillTree = %SkillTree

func _ready() -> void:
	await get_tree().process_frame

func on_pause() -> void:
	abilities_inv.on_pause()
	skill_tree.on_pause()
	abilities_inv.update_ability_visuals()

func on_resume() -> void:
	abilities_inv.on_resume()
	skill_tree.on_resume()
