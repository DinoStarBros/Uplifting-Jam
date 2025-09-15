extends Control
class_name SkillTree

@onready var pointer: Sprite2D = %pointer
@onready var desc_txt: Label = %descTxt
@onready var unlock_hold_bar: ProgressBar = %unlock_hold
@onready var descBox: PanelContainer = %descBox
@onready var descTxt: Label = %descTxt

var unlock_hold_prog : float = 0
var skills_in_tree : Array
var skills_unlockeds : Array

const UNLOCK_HOLD_PROG_MAX : float = 1

func _ready() -> void:
	skills_in_tree.clear()
	for child in get_children():
		if child is SkillButton:
			skills_in_tree.append(n)
	_load()

func on_pause() -> void:
	#_load()
	pass

func on_resume() -> void:
	_save()

func update_skill_arrays() -> void:
	skills_in_tree.clear()
	skills_unlockeds.clear()
	for child in get_children():
		if child is SkillButton:
			skills_in_tree.append(child)
			skills_unlockeds.append(child.unlocked)
			child.update()

#func set_skills_values() -> void:
#	var n : int = -1
#	for skill : SkillButton in skills_in_tree:
#		n += 1
#		if skills_unlockeds[n]:
#			skill.pressed_b()
#		skill.update()

func ability_pressed() -> void:
	update_skill_arrays()

func _process(delta: float) -> void:
	if Global.focused_node is SkillButton:
		pointer.visible = true
		pointer.global_position = pointer.global_position.lerp(
		Global.focused_node.global_position + Vector2(44,44),
		12 * delta
		)
	else:
		pointer.visible = false
	
	if Global.focused_node is SkillButton: 
	# A skill tree skill has been selected
		
		if Global.focused_node.unlockable:
			if Input.is_action_pressed("unlock_skill"):
				unlock_hold_prog += delta
			else:
				unlock_hold_prog = 0
			
			if unlock_hold_prog >= UNLOCK_HOLD_PROG_MAX:
				Global.focused_node.pressed_b()
				
				unlock_hold_prog = 0
				for skill : SkillButton in skills_in_tree:
					skill.update()
				
				_save()
		
		unlock_hold_bar.visible = Global.focused_node.unlockable and not Global.focused_node.unlocked
		%locked.visible = !Global.focused_node.unlockable
		
		_visuals_stuff()
		
	else:
		unlock_hold_prog = 0
	
	
	descBox.visible = Global.focused_node is SkillButton
	

func _visuals_stuff() -> void:
	unlock_hold_bar.max_value = UNLOCK_HOLD_PROG_MAX
	unlock_hold_bar.value = unlock_hold_prog
	
	descTxt.text = str(
	Global.focused_node.name,
	": \n",
	Global.focused_node.description
	)

func _save() -> void:
	SaveLoad.SaveFileData.skills_unlockeds = skills_unlockeds
	
	SaveLoad._save()

var n : int = -1
func _load() -> void:
	skills_unlockeds = SaveLoad.SaveFileData.skills_unlockeds
	
	SaveLoad._load()
	
	skills_in_tree.clear()
	for n in get_children():
		if n is SkillButton:
			skills_in_tree.append(n)
	
	n = -1
	
	for skill : SkillButton in skills_in_tree:
		n += 1
		if SaveLoad.SaveFileData.skills_unlockeds[n]:
			skill.pressed_b()

func _on_reset_pressed()->void:
	SaveLoad._reset_save_file()
	SaveLoad._load()
	
	skills_unlockeds = SaveLoad.SaveFileData.skills_unlockeds
