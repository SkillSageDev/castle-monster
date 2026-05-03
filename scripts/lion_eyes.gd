extends Node3D

@onready var camera: Camera3D = get_viewport().get_camera_3d()

# Max rotation in degrees
@export var max_yaw: float = 15   # left/right
@export var max_pitch: float = 25 # up/down

func _process(delta: float) -> void:
	var viewport_size: Vector2 = get_viewport().get_visible_rect().size
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	
	var normalized: Vector2 = (mouse_pos / viewport_size) * 2.0 - Vector2.ONE
	
	# Apply rotation directly — no look_at(), no flipping
	rotation.y = deg_to_rad(clampf(normalized.x * max_yaw, -40, 40))
	rotation.z = deg_to_rad(clampf(normalized.y * max_pitch, -20, 15))
