extends "../Motion.gd"

export(float) var max_speed = 5.0
export(float) var max_fall = 75.0
export(float) var push_force = 10.0
export(float) var slide_gravity = 30.0


func exit(host: Node) -> void: # Clean up. Reset values.
	host.velocity.x = 0


func handle_input(host: Node):
	if player_controller.get_jump():
		host.velocity.x = max_speed * get_input_direction()
		host.velocity.y = push_force
		emit_signal("finished", "Jump")
	return .handle_input(host)


func update(host: Node, delta: float) -> void:
	# warning-ignore:return_value_discarded
	get_input_direction() # Updates the sprite direction based on the player's input
	
	host.velocity.y = move_toward(host.velocity.y, \
								  max_fall, \
								  slide_gravity * delta) \
								  * -1
	
	host.kinematic_body.move_and_slide(host.velocity, Vector3.UP)
	
	if is_on_floor(host):
		emit_signal("finished", "Idle")
	
	if not is_on_wall(host):
		emit_signal("finished", "WallSlide")


func is_on_floor(host: Node) -> bool:
	return host.kinematic_body.is_on_floor()


func is_on_wall(host: Node) -> bool:
	return host.kinematic_body.is_on_wall()
