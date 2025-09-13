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
var ndex : int = 0
var description : String

func _ready() -> void:
	skill_tree = get_parent()
	
	label.text = str(level) + "/" + str(MAX_LEVEL)
	#if get_parent() is SkillButton:
	for prereq_skill in prerequisite_skills:
		line_2d.add_point(global_position + (size*scale)/2)
		line_2d.add_point(prereq_skill.global_position + (size*scale)/2)
		
		#ndex += 1
		#line_2d.points[ndex-1].y += size.y / 2
		#line_2d.points[ndex].y += size.y / 2

var prereq_skl_lvls : Array
func _pressed_b() -> void:
	if level < MAX_LEVEL:
		skill_up()

func skill_up() -> void:
	prereq_skl_lvls.clear()
	if prerequisite_skills.size() != 0:
		
		for skill in prerequisite_skills:
			prereq_skl_lvls.append(skill.level)
		
		if prereq_skl_lvls.count(1) == prereq_skl_lvls.size():
			
			level = min(level+1, MAX_LEVEL)
			panel.show_behind_parent = true
			
			line_2d.default_color = Color.GREEN
		
		skill_tree.ability_pressed()
	else:
		
		level = min(level+1, MAX_LEVEL)
		panel.show_behind_parent = true
		
		skill_tree.ability_pressed()

func _process(delta: float) -> void:
	if Global.focused_node == self:
		if Input.is_action_just_pressed("unlock_skill"):
			_pressed_b()
