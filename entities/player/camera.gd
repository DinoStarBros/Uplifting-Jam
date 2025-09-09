extends Camera2D
class_name Cam

@export var limit_camera : bool = true

func _ready() -> void:
	Global.cam = self
	#%camLimArea.area_entered.connect(_on_camlim_area_entered)

var shake_intensity: float = 0.0
var active_shake_time:float = 0.0

var shake_decay: float = 5.0

var shake_time: float = 0.0
var shake_time_speed: float = 20.0

var noise : FastNoiseLite = FastNoiseLite.new()

func _physics_process(delta:float) -> void:

	
	if active_shake_time > 0:
		shake_time += delta * shake_time_speed
		active_shake_time -= delta
		
		if Global.screen_shake_value:
			offset = Vector2(
				noise.get_noise_2d(shake_time, 0) * shake_intensity,
				noise.get_noise_2d(0, shake_time) * shake_intensity,
			)
		
		shake_intensity = max(shake_intensity - shake_decay * delta, 0)
	else:
		offset = lerp(offset, Vector2.ZERO, 10.5 * delta)
		shake_intensity = 0

func screen_shake(intensity: int, time: float) -> void: ## Shakes the camera with an intensity, for some duration of time, Use for da juice
	
	randomize()
	noise.seed = randi()
	noise.frequency = 2.0
	
	if intensity > shake_intensity:
		# It'll only apply if a stronger shake happens
		# So that it doesn't get overidden by a weak shake
		shake_intensity = intensity
	
	if time > active_shake_time:
		# It'll only apply if a stronger shake happens
		# So that it doesn't get overidden by a weak shake
		active_shake_time = time
	
	shake_time = 0.0

func _on_camlim_area_entered(area: Area2D) -> void:
	var room : CollisionShape2D = area.find_child("room")
	var room_size : Vector2 = room.shape.size
	
	var negative_bounds : Vector2 = Vector2( ## Top Left of room
		room.global_position.x - (room_size.x/2), room.global_position.y - (room_size.y/2)
		)
	var positive_bounds : Vector2 = Vector2( ## Bottom Right of room
		room.global_position.x + (room_size.x/2), room.global_position.y + (room_size.y/2)
	)
	
	if limit_camera:
		limit_left = int(negative_bounds.x)
		limit_top = int(negative_bounds.y)
		
		limit_right = int(positive_bounds.x)
		limit_bottom = int(positive_bounds.y)
