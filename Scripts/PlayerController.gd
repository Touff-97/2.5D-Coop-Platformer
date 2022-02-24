extends Node

onready var player

enum inputType {
	CONTROLLER,
	KEYBOARD,
}

export(inputType) var input_type = inputType.CONTROLLER
export(bool) var controller_connected = false


func get_connection() -> bool:
	return false


func get_direction() -> float:
	return 0.0


func get_jump() -> bool:
	return false


func get_action() -> bool:
	return false


func get_switch() -> bool:
	return false


# Helper functions
func is_type(type: int) -> bool:
	return type == input_type
