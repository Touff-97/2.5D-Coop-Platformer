extends "../State.gd"


func get_input_direction() -> float:
	return player_controller.get_direction()
