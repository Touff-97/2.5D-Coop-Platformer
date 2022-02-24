extends "OnGround.gd"


func enter(host: Node) -> void: # Animation here
	host.velocity.x = 0.0


func handle_input(host: Node):
	return .handle_input(host)


func update(host: Node, delta: float) -> void:
	var input_direction = get_input_direction()
	if input_direction != 0.0:
		emit_signal("finished", "Walk")
	
	get_ground_gravity(host, delta)
