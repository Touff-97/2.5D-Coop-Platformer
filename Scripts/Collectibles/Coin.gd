extends Sprite3D

onready var tween : Tween = $Tween
onready var coin_position : Vector3 = translation
onready var coin_rotation : Vector3 = rotation_degrees

export(float) var coin_value = 200

signal coin_collected(value, color, player)


func _ready() -> void:
	add_to_group("Coin")
	modulate = get_coin_color()
	translate_coin()
	rotate_coin()


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


func translate_coin() -> void:
	# warning-ignore:return_value_discarded
	tween.interpolate_property(self, "translation", Vector3(coin_position.x, coin_position.y, coin_position.z), \
							   Vector3(coin_position.x, coin_position.y - 0.05, coin_position.z), 0.6, \
							   Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	coin_position = Vector3(coin_position.x, coin_position.y - 0.05, coin_position.z)
	# warning-ignore:return_value_discarded
	tween.interpolate_property(self, "translation", Vector3(coin_position.x, coin_position.y, coin_position.z), \
							   Vector3(coin_position.x, coin_position.y + 0.05, coin_position.z), 0.6, \
							   Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.6)
	tween.repeat = true
	# warning-ignore:return_value_discarded
	tween.start()


func rotate_coin() -> void:
	# warning-ignore:return_value_discarded
	tween.interpolate_property(self, "rotation_degrees", Vector3(coin_rotation.x, rotation.y, rotation.z), \
							   Vector3(coin_rotation.x, rotation.y - 180, rotation.z), 1.2, \
							   Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)


func _on_Area_body_entered(body: Node) -> void:
	if body:
		var player = body.name
		print(body.name + " collected a " + str(coin_value) + "c coin!")
		
		emit_signal("coin_collected", coin_value, get_coin_color(), player)
		queue_free()
