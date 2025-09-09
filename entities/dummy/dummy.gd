extends CharacterBody2D
class_name Dummy

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += Global.GRAVITY * delta
	
	move_and_slide()
	velocity.x *= 0.9

func damaged(attack:Attack) -> void:
	velocity = attack.knockback_direction * attack.knockback
	
	%ene_hit.pitch_scale = randf_range(0.8, 1.2)
	%ene_hit.play()

func dead(attack:Attack) -> void:
	queue_free()
