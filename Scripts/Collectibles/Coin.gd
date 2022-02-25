extends Sprite3D

export(float) var coin_value = 200

signal coin_collected(value, color, player)


func _ready() -> void:
	add_to_group("Coin")
	modulate = get_coin_color()


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


func _on_Area_body_entered(body: Node) -> void:
	if body:
		var player = body.name
		print("Coin collected!")
		
		emit_signal("coin_collected", coin_value, get_coin_color(), player)
		queue_free()
