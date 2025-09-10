extends StatePlr

func _ready() -> void:
	await get_tree().process_frame
	p.sm.change_state("dash")

func on_enter() -> void:
	pass

func process(delta: float)-> void:
	p.enable_gravity = true
	p.override_flip_sprite = false
	p.velocity.x = p.x_input * p.SPEED
	p.slash_handling()
	p.ability_handling(delta)
	
	if not Input.is_action_pressed("jump") and p.velocity.y < 0:
		p.velocity.y = 0
	
	if p.velocity.x == 0:
		p.anim.play("idle")
	else:
		p.anim.play("walk")
	
	if (Input.is_action_just_pressed("jump") or p.next_buffered_state == "jump") and p.is_on_floor():
		p.sm.change_state("jump")
		
	if not p.is_on_floor():
		p.sm.change_state("fall")
	
	p.dash_handling()

func on_exit()-> void:
	pass
