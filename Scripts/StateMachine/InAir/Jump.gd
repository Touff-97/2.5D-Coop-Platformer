extends "../Motion.gd"

export(float) var max_speed = 3
export(float) var acceleration = 30
export(float) var max_fall = 100

export(bool) var jump_pressed = false
export(bool) var can_air_jump = true
export(float) var jump_height
export(float) var jump_time_to_peak
export(float) var jump_time_to_descent
export(float) onready var jump_velocity = ((2.0 * jump_height) / jump_time_to_peak)
export(float) onready var jump_gravity = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak))
export(float) onready var fall_gravity = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent))


func exit(host: Node) -> void: # Clean up. Reset values.
	host.velocity.y = 0.0


func update(host: Node, delta: float) -> void:
	jump_pressed = true
	remember_jump_time()
	if can_air_jump:
		can_air_jump = false
		host.velocity.y = jump_velocity
	
	host.velocity.x = move_toward(host.velocity.x, \
								  max_speed * get_input_direction(), \
								  acceleration * delta)
	host.velocity.y = move_toward(host.velocity.y, \
								  max_fall, \
								  get_gravity(host) * delta)
	
	host.kinematic_body.move_and_slide(host.velocity, Vector3.UP)
	
	if is_grounded(host):
		can_air_jump = true
		if jump_pressed:
			host.velocity.y = jump_velocity
		emit_signal("finished", "Walk")
	else:
		coyote_time()


# Helper functions
func get_gravity(host: Node) -> float:
	return jump_gravity if host.velocity.y < 0.0 else fall_gravity


func is_grounded(host: Node) -> bool:
	return host.kinematic_body.is_on_floor()


func coyote_time() -> void:
	yield(get_tree().create_timer(0.01), "timeout")
	can_air_jump = false


func remember_jump_time() -> void:
	yield(get_tree().create_timer(0.05), "timeout")
	jump_pressed = false
