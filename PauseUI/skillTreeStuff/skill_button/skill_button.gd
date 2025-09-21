extends TextureButton
class_name SkillButton

@onready var panel: Panel = %Panel
@onready var line_2d: Line2D = %Line2D

@export var prerequisite_skills : Array[SkillButton]
@export_multiline var description : String
@export var inspiration_cost : int = 1

var skill_tree : SkillTree
var ndex : int = 0
var unlockable : bool = false
var unlocked : bool

func _ready() -> void:
	skill_tree = get_parent()
	
	for prereq_skill in prerequisite_skills:
		line_2d.add_point(global_position + (size*scale)/2)
		line_2d.add_point(prereq_skill.global_position + (size*scale)/2)
	
	update()

var prereq_skl_unlockeds : Array
func pressed_b() -> void:
	unlocked = true
	skill_up()
	Global.inspiration -= inspiration_cost
	
	SaveLoad.SaveFileData.inspiration = Global.inspiration
	SaveLoad._save()

func skill_up() -> void:
	
	prereq_skl_unlockeds.clear()
	
	line_2d.default_color = Color.GREEN
	
	skill_tree.ability_pressed()

func _process(delta: float) -> void:
	
	unlockable = prereq_skl_unlockeds.count(true) == prerequisite_skills.size()
	
	%Label.text = str(unlocked)

func update() -> void:
	prereq_skl_unlockeds.clear()
	
	for skill in prerequisite_skills:
		prereq_skl_unlockeds.append(skill.unlocked)
	
	panel.show_behind_parent = unlocked
	unlockable = prereq_skl_unlockeds.count(true) == prerequisite_skills.size()

func _save() -> void:
	SaveLoad.SaveFileData.inspiration = Global.inspiration
	
	SaveLoad._save()

func _load() -> void:
	Global.inspiration = SaveLoad.SaveFileData.inspiration
	
	SaveLoad._load()
