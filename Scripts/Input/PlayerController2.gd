extends "res://Scripts/PlayerController.gd"


func get_connection() -> bool:
	var connected : bool
	
	if Input.is_action_just_pressed("controller_connect_1"):
		input_type = inputType.CONTROLLER
		connected = Input.is_action_just_pressed("controller_connect_1")
	elif Input.is_action_just_pressed("keyboard_connect_1"):
		input_type = inputType.KEYBOARD
		connected = Input.is_action_just_pressed("keyboard_connect_1")
	
	return connected


func get_direction() -> float:
	var direction : float
	
	if is_type(0): # Controller input
		direction = sign(Input.get_action_strength("controller_right_1") - \
						 Input.get_action_strength("controller_left_1"))
	elif is_type(1): # Keyboard input
		direction = sign(Input.get_action_strength("keyboard_right_1") - \
						 Input.get_action_strength("keyboard_left_1"))
	
	if player:
		if direction > 0:
			player.sprite.flip_h = false
			player.raycast.cast_to = (Vector3.RIGHT * 0.2)
		elif direction < 0:
			player.sprite.flip_h = true
			player.raycast.cast_to = (Vector3.LEFT * 0.2)
	
	return direction


func get_jump() -> bool:
	var jumping : bool
	
	if is_type(0):
		jumping = Input.is_action_just_pressed("controller_jump_1")
	elif is_type(1):
		jumping = Input.is_action_just_pressed("keyboard_jump_1")
	
	return jumping


func get_action() -> bool:
	var acting : bool
	
	if is_type(0):
		acting = Input.is_action_just_pressed("controller_action_1")
	elif is_type(1):
		acting = Input.is_action_just_pressed("keyboard_action_1")
	
	return acting


func get_save() -> bool:
	var saving : bool
	
	if is_type(0):
		saving = Input.is_action_just_pressed("controller_save_1")
	elif is_type(1):
		saving = Input.is_action_just_pressed("keyboard_save_1")
	
	return saving


func get_switch() -> bool:
	var switching : bool
	
	if is_type(0):
		switching = Input.is_action_just_pressed("controller_switch_1")
	elif is_type(1):
		switching = Input.is_action_just_pressed("keyboard_switch_1")
	
	return switching
