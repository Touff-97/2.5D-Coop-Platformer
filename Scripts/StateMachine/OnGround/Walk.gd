extends "OnGround.gd"

export(float) var max_speed = 3
export(float) var acceleration = 30


func enter(_host: Node) -> void: # Initialize. Change the animation.
	return


func handle_input(host: Node):
	return .handle_input(host)


func update(host: Node, delta: float) -> void:
	var input_direction = get_input_direction()
	if input_direction == 0.0:
		emit_signal("finished", "Idle")
	
	host.velocity.x = move_toward(host.velocity.x, \
								  max_speed * input_direction, \
								  acceleration * delta)
	
	get_ground_gravity(host, delta)
