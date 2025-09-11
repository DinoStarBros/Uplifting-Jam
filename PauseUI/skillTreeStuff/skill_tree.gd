extends Control
class_name SkillTree

var skills_in_tree : Array
var skills_levels : Array

func _ready() -> void:
	update_skill_arrays()
	print(skills_in_tree)
	print(skills_levels)

func update_skill_arrays() -> void:
	skills_in_tree.clear()
	skills_levels.clear()
	for child in get_children():
		if child is SkillButton:
			skills_in_tree.append(child)
			skills_levels.append(child.level)

func set_skills_values() -> void:
	for n in skills_in_tree:
		pass

func ability_pressed() -> void:
	update_skill_arrays()
	set_skills_values()
