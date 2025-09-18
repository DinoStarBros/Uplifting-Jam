extends StatePlr


func _ready() -> void:
	await get_tree().process_frame
	p.sm.change_state("dash")
	#pass

func on_enter() -> void:
	pass

func process(delta: float) -> void:
	if p.velocity.x == 0:
		p.anim.play("idle")
	else:
		p.anim.play("walk")
	
	p.enable_gravity = true
	p.override_flip_sprite = false
	p.move_handling()
	p.slash_handling()
	p.ability_handling(delta)
	
	if p.scene_just_started:
		if p.is_on_floor():
			p.sm.change_state("wakeUp")
	
	if not Input.is_action_pressed("jump") and p.velocity.y < 0:
		p.velocity.y = 0
	
	if (Input.is_action_just_pressed("jump") or p.next_buffered_state == "jump") and p.is_on_floor():
		p.sm.change_state("jump")
		
	if not p.is_on_floor():
		p.sm.change_state("fall")
	
	p.dash_handling()

func on_exit()-> void:
	pass
