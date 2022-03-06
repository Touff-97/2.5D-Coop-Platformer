tool
extends "res://Scripts/Collectible.gd"

export(float) var token_value = 2500


func _ready() -> void:
	add_to_group("Token")
	._ready()


func _on_collectibleArea_body_entered(body: Node) -> void:
	if body is KinematicBody:
		var player = body.input_controller.name
		print(player + " collected a " + str(token_value) + "c token!")
		
		emit_signal("_on_collected", player, "Token", token_value)
		queue_free()
