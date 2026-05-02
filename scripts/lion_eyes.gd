extends Node3D

@onready var camera: Camera3D = get_viewport().get_camera_3d()

# Max rotation in degrees
@export var max_yaw: float = 25.0    # left/right
@export var max_pitch: float = 25.0  # up/down

func _process(delta: float) -> void:
	var viewport_size: Vector2 = get_viewport().get_visible_rect().size
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	
	# Normalize mouse to -1..1 relative to viewport center
	var normalized: Vector2 = (mouse_pos / viewport_size) * 2.0 - Vector2.ONE
	# normalized.x = -1 (left) to 1 (right)
	# normalized.y = -1 (top) to 1 (bottom)
	
	# Apply rotation directly — no look_at(), no flipping
	rotation.y = deg_to_rad(normalized.x * max_yaw)
	rotation.x = deg_to_rad(normalized.y * max_pitch)
