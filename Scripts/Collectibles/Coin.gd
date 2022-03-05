tool
extends "res://Scripts/Collectible.gd"

export(float, EXP, 200, 1000, 200) var coin_value = 200


func _ready() -> void:
	._ready()
	add_to_group("Coin")
	modulate = get_coin_color()


func _on_collectibleArea_body_entered(body: Node) -> void:
	if body is KinematicBody:
		var player = body.input_controller.name
		print(player + " collected a " + str(coin_value) + "c coin!")
		
		emit_signal("_on_collected", player, "Coin", coin_value, get_coin_color())
		queue_free()


func get_coin_color() -> Color:
	var coin_color : Color

	match str(coin_value): # Differentiate the different value coins by color
		"200":
			coin_color = Color.red

		"400":
			coin_color = Color.orange

		"600":
			coin_color = Color.yellow

		"800":
			coin_color = Color.green

		"1000":
			coin_color = Color.blue

	return coin_color
