extends "res://Scripts/PlayerController.gd"


func get_connection() -> bool:
	var connected : bool
	
	if Input.is_action_just_pressed("controller_connect_0"):
		input_type = inputType.CONTROLLER
		connected = Input.is_action_just_pressed("controller_connect_0")
	elif Input.is_action_just_pressed("keyboard_connect_0"):
		input_type = inputType.KEYBOARD
		connected = Input.is_action_just_pressed("keyboard_connect_0")
	
	return connected


func get_direction() -> float:
	var direction : float
	
	if is_type(0): # Controller input
		direction = sign(Input.get_action_strength("controller_right_0") - \
						 Input.get_action_strength("controller_left_0"))
	elif is_type(1): # Keyboard input
		direction = sign(Input.get_action_strength("keyboard_right_0") - \
						 Input.get_action_strength("keyboard_left_0"))
	
	if player:
		if direction > 0:
			player.sprite.flip_h = false
		elif direction < 0:
			player.sprite.flip_h = true
	
	return direction


func get_jump() -> bool:
	var jumping : bool
	
	if is_type(0):
		jumping = Input.is_action_just_pressed("controller_jump_0")
	elif is_type(1):
		jumping = Input.is_action_just_pressed("keyboard_jump_0")
	
	return jumping


func get_action() -> bool:
	var acting : bool
	
	if is_type(0):
		acting = Input.is_action_just_pressed("controller_action_0")
	elif is_type(1):
		acting = Input.is_action_just_pressed("keyboard_action_0")
	
	return acting


func get_save() -> bool:
	var saving : bool
	
	if is_type(0):
		saving = Input.is_action_just_pressed("controller_save_0")
	elif is_type(1):
		saving = Input.is_action_just_pressed("keyboard_save_0")
	
	return saving


func get_switch() -> bool:
	var switching : bool
	
	if is_type(0):
		switching = Input.is_action_just_pressed("controller_switch_0")
	elif is_type(1):
		switching = Input.is_action_just_pressed("keyboard_switch_0")
	
	return switching
