extends Sprite3D

onready var collectible_position : Vector3 = translation
onready var collectible_rotation : Vector3 = rotation_degrees
onready var tween : Tween = $Tween

# warning-ignore:unused_signal
signal _on_collected(player, collectible, value, color)


func _ready() -> void:
	animate_collectible()


func animate_collectible() -> void:
	var animation_time : float = 1.2
	var translation_offset : float = 0.05
	var rotation_offset : float = 180.0
	# Translation #
	# warning-ignore:return_value_discarded
	tween.interpolate_property(self, "translation", Vector3(collectible_position.x, collectible_position.y, collectible_position.z), \
							   Vector3(collectible_position.x, collectible_position.y - translation_offset, collectible_position.z), animation_time / 2, \
							   Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	collectible_position = Vector3(collectible_position.x, collectible_position.y - translation_offset, collectible_position.z)
	# warning-ignore:return_value_discarded
	tween.interpolate_property(self, "translation", Vector3(collectible_position.x, collectible_position.y, collectible_position.z), \
							   Vector3(collectible_position.x, collectible_position.y + translation_offset, collectible_position.z), animation_time / 2, \
							   Tween.TRANS_LINEAR, Tween.EASE_OUT, animation_time / 2)
	# Rotation #
	# warning-ignore:return_value_discarded
	tween.interpolate_property(self, "rotation_degrees", Vector3(collectible_rotation.x, collectible_rotation.y, collectible_rotation.z), \
							   Vector3(collectible_rotation.x, collectible_rotation.y - rotation_offset, collectible_rotation.z), animation_time, \
							   Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
	tween.repeat = true
	# warning-ignore:return_value_discarded
	tween.start()


func _on_collectibleArea_body_entered(_body: Node) -> void:
	pass # Replace with function body.
