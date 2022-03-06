extends Node

onready var camera : Camera = $Camera
onready var actual_cam_pos : Vector3 = camera.translation

onready var player_1 : KinematicBody
onready var player_2 : KinematicBody

export(float) var camera_weight = 0.5
export(float) var camera_zoom_min = 0.0
export(float) var camera_zoom_max = 8.0
export(float) var camera_margin_x = 80.0
export(float) var camera_pos_sensitivity = 5.0


func _ready() -> void:
	add_to_group("Awaiting Player")


func _process(delta: float) -> void:
	# Control the weight for the camera for 1 player and 2 players
	if player_1 != null and player_2 != null:
		if player_1.active and not player_2.active:
			camera_weight = 0.3
		elif not player_1.active and player_2.active:
			camera_weight = 0.7
		else:
			camera_weight = 0.5
		
		# Set the camera zoom, AKA its z position
		var camera_zoom : float = camera_zoom_min
		if abs(player_1.translation.x - player_2.translation.x) > camera_zoom_min:
			camera_zoom = clamp(lerp(camera_zoom_min, \
									 camera_zoom_max, \
									 (abs(player_1.translation.x - player_2.translation.x) * 5) * delta), \
								camera_zoom_min, \
								camera_zoom_max)
		elif abs(player_1.translation.y - player_2.translation.y) > camera_zoom_min:
			camera_zoom = clamp(lerp(camera_zoom_min, \
									 camera_zoom_max, \
									 (abs(player_1.translation.y - player_2.translation.y) * 5) * delta), \
								camera_zoom_min, \
								camera_zoom_max)
		else:
			camera_zoom = camera_zoom_min
		
		# Set the position of the camera in between the players
		var cam_pos = lerp(Vector3(player_1.translation.x, player_1.translation.y + camera_zoom, (player_1.translation.z + 2) + camera_zoom), \
						   Vector3(player_2.translation.x, player_2.translation.y + camera_zoom, (player_2.translation.z + 2) + camera_zoom), \
						   camera_weight)
		
		camera.look_at(Vector3(cam_pos.x + camera_weight, cam_pos.y * camera_weight, 0), Vector3.UP)
		
		actual_cam_pos = lerp(actual_cam_pos, cam_pos, camera_pos_sensitivity * delta)
		camera.translation = actual_cam_pos
