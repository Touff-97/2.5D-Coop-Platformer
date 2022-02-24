extends "../Motion.gd"

var max_fall : float = 100.0
var gravity : float = 200.0


func handle_input(host: Node):
	if player_controller.get_jump():
		print("Jump!")
		emit_signal("finished", "Jump")
	return .handle_input(host)


func get_ground_gravity(host: Node, delta: float) -> void:
	host.velocity.y = move_toward(host.velocity.y, \
								  max_fall, \
								  gravity * delta) \
								  * -1.0
	host.kinematic_body.move_and_slide(host.velocity, Vector3.UP)
