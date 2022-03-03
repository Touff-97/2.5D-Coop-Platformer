extends "res://Scripts/Collectible.gd"

export(float) var boat_value = 5000


func _ready() -> void:
	add_to_group("PaperBoat")
	._ready()


func _on_collectibleArea_body_entered(body: Node) -> void:
	if body:
		var player = body.input_controller.name
		print(player + " collected a " + str(boat_value) + "c paper boat!")
		
		emit_signal("_on_collected", player, "PaperBoat", boat_value)
		queue_free()
