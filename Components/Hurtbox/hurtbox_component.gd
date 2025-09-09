extends Area2D
class_name HurtboxComponent

@export var health_component : HealthComponent
@export var ouchnim : AnimationPlayer

func on_hit(attack: Attack) -> void:
	health_component.hp -= attack.damage
	%Hitspark.look_at(global_position-attack.knockback_direction)
	%Hitspark.rotation_degrees += 180
	%fxAnim.play("on_hit")
	ouchnim.play("ouch")
	
	if health_component.hp > 0:
		if owner.has_method("damaged"):
			owner.damaged(attack)
		
		%hit1.pitch_scale = randf_range(0.3, 0.5)
		%hit1.play()
		%hit2.pitch_scale = randf_range(0.9, 1.1)
		%hit2.play()
	else:
		if owner.has_method("dead"):
			owner.dead(attack)
