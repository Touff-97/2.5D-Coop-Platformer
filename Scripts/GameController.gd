extends Spatial

onready var players : Array = []

var max_player_count : int = 2


func _ready() -> void:
	for i in range(max_player_count):
		var new_player = find_node("Player_" + str(i + 1))
		players.append(new_player)


func _on_Player_1_player_ready() -> void:
	var dep_nodes = get_tree().get_nodes_in_group("Awaiting Player")
	yield(get_tree(), "idle_frame")
	for node in dep_nodes:
		node.player_1 = players[0]


func _on_Player_2_player_ready() -> void:
	var dep_nodes = get_tree().get_nodes_in_group("Awaiting Player")
	yield(get_tree(), "idle_frame")
	for node in dep_nodes:
		node.player_2 = players[1]


# Input Controller
func _on_InputController_player_connected(controller: Node) -> void:
	for player in players:
		if not player.active:
			player.input_controller = controller
			controller.player = player
			
			player.activate()
		
			print(player.name + " using " + controller.name + " connected.\n")
			break


func _on_InputController_player_disconnected(controller: Node) -> void:
	for player in players:
		if player.input_controller == controller:
			player.input_controller = null
			controller.player = null
			
			player.deactivate()
		
			print(player.name + " using " + controller.name + " disconnected.\n")
			break


func _on_InputController_player_switch(controller: Node) -> void:
	for player in players:
		if player.active:
			match player.name:
				"Player_1":
					# Assign player and controller
					players[0].input_controller = null
					players[1].input_controller = controller
					controller.player = players[1]
					# Switch active players
					players[0].deactivate()
					players[1].activate()
					print(controller.name + " now controls the " + players[1].name)
				
				"Player_2":
					# Assign player and controller
					players[0].input_controller = controller
					players[1].input_controller = null
					controller.player = players[0]
					# Switch active players
					players[0].activate()
					players[1].deactivate()
					print(controller.name + " now controls the " + players[0].name)