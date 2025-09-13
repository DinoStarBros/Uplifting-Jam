extends Control
class_name SkillTree

@onready var pointer: Sprite2D = %pointer

var skills_in_tree : Array
var skills_levels : Array

func _ready() -> void:
	update_skill_arrays()

func update_skill_arrays() -> void:
	skills_in_tree.clear()
	skills_levels.clear()
	for child in get_children():
		if child is SkillButton:
			skills_in_tree.append(child)
			skills_levels.append(child.level)

func set_skills_values() -> void:
	for skill : SkillButton in skills_in_tree:
		pass

func ability_pressed() -> void:
	update_skill_arrays()
	set_skills_values()

func _process(delta: float) -> void:
	if Global.focused_node is SkillButton:
		pointer.visible = true
		pointer.global_position = pointer.global_position.lerp(
		Global.focused_node.global_position + Vector2(44,44),
		12 * delta
		)
	else:
		pointer.visible = false
