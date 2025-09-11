extends TextureButton
class_name SkillButton

@onready var panel: Panel = %Panel
@onready var label: Label = %Label
@onready var line_2d: Line2D = %Line2D

@export var prerequisite_skills : Array[SkillButton]

const MAX_LEVEL : int = 1

var level : int = 0:
	set(value):
		level = value
		label.text = str(level) + "/" + str(MAX_LEVEL)
var skill_tree : SkillTree

func _ready() -> void:
	skill_tree = get_parent()
	
	pressed.connect(_pressed)
	label.text = str(level) + "/" + str(MAX_LEVEL)
	if get_parent() is SkillButton:
		line_2d.add_point(global_position + size/2)
		line_2d.add_point(get_parent().global_position + size/2)
		
		line_2d.points[0].y += size.y / 2
		line_2d.points[1].y += size.y / 2

var prereq_skl_lvls : Array
func _pressed() -> void:
	prereq_skl_lvls.clear()
	if prerequisite_skills.size() != 0:
		
		for skill in prerequisite_skills:
			prereq_skl_lvls.append(skill.level)
		
		if prereq_skl_lvls.count(1) == prereq_skl_lvls.size():
			level = min(level+1, MAX_LEVEL)
			panel.show_behind_parent = true
			
			line_2d.default_color = Color.SKY_BLUE
		
		skill_tree.ability_pressed()
	else:
		
		level = min(level+1, MAX_LEVEL)
		panel.show_behind_parent = true
		
		line_2d.default_color = Color.SKY_BLUE
		
		skill_tree.ability_pressed()
