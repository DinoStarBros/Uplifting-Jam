extends Area2D
class_name HurtboxComponent

@export var health_component : HealthComponent
@export var hitspark_scale : Vector2 = Vector2(1,1)
@export var ouchnim : AnimationPlayer
@export var deathnim : AnimationPlayer

@onready var hitspark: Sprite2D = %Hitspark

var collision_shape : CollisionShape2D ## DISCLAIMER: Hurtbox Components should only have one collision shape cuz this is only one variable

func _ready() -> void:
	hitspark.scale = hitspark_scale
	for child in get_children():
		if child is CollisionShape2D:
			collision_shape = child

func on_hit(attack: Attack) -> void:
	health_component.took_damage(attack)
	health_component.hp -= attack.damage
	hitspark.look_at(global_position-attack.knockback_direction)
	hitspark.rotation_degrees += 180
	%fxAnim.play("on_hit")
	
	if health_component.hp > 0:# Hit
		if ouchnim:
			ouchnim.play("ouch")
		
		if owner.has_method("damaged"):
			owner.damaged(attack)
		
	
	else:# Dead
		call_deferred("disable_csp")
		if deathnim:
			deathnim.play("death")
		
		if owner.has_method("dead"):
			owner.dead(attack)

func disable_csp() -> void:
	collision_shape.disabled = true
