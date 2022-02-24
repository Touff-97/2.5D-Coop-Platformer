extends Node

onready var controllers : Array = []

signal player_connected(controller)
signal player_disconnected(controller)
signal player_switch(controller)


func _ready() -> void:
	for i in range(2):
		var new_player = find_node("PlayerController" + str(i + 1))
		controllers.append(new_player)


func _process(_delta: float) -> void:
	check_player_connection()
	check_player_switch()


func check_player_connection() -> void:
	for controller in controllers:
		if controller.get_connection():
			if not controller.controller_connected:
				controller.controller_connected = true
				connect_player(controller)
			else:
				controller.controller_connected = false
				disconnect_player(controller)


func connect_player(controller: Node) -> void:
	print("Connecting " + controller.name + " with player...")
	emit_signal("player_connected", controller)


func disconnect_player(controller: Node) -> void:
	print("Disconnecting " + controller.name + " with player...")
	emit_signal("player_disconnected", controller)


func check_player_switch() -> void:
	for controller in controllers:
		if controller.get_switch():
			if not is_coop():
				print("Switching " + controller.name + "...")
				controller.player = null
				emit_signal("player_switch", controller)


func is_coop() -> bool:
	return controllers[0].player and controllers[1].player
