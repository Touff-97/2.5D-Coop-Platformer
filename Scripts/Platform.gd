tool
extends StaticBody

onready var platform_position : Vector3 = translation
onready var tween : Tween = $Tween

export(bool) onready var is_vertical
export(float) onready var translation_offset
export(float) onready var animation_time
export(float) onready var time_offset


func _ready() -> void:
	if is_vertical:
		move_in_y_axis()
	else:
		move_in_x_axis()


func move_in_y_axis() -> void:
	# warning-ignore:return_value_discarded
	tween.interpolate_property(self, "translation", \
							   Vector3(platform_position.x, platform_position.y, platform_position.z), \
							   Vector3(platform_position.x, platform_position.y - translation_offset, platform_position.z), \
							   animation_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0 + time_offset)
	platform_position = Vector3(platform_position.x, platform_position.y - translation_offset, platform_position.z)
	# warning-ignore:return_value_discarded
	tween.interpolate_property(self, "translation", \
							   Vector3(platform_position.x, platform_position.y, platform_position.z), \
							   Vector3(platform_position.x, platform_position.y + translation_offset, platform_position.z), \
							   animation_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, animation_time + (time_offset * 2))
	tween.repeat = true
	# warning-ignore:return_value_discarded
	tween.start()


func move_in_x_axis() -> void:
	# warning-ignore:return_value_discarded
	tween.interpolate_property(self, "translation", \
							   Vector3(platform_position.x, platform_position.y, platform_position.z), \
							   Vector3(platform_position.x - translation_offset, platform_position.y, platform_position.z), \
							   animation_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0 + time_offset)
	platform_position = Vector3(platform_position.x - translation_offset, platform_position.y, platform_position.z)
	# warning-ignore:return_value_discarded
	tween.interpolate_property(self, "translation", \
							   Vector3(platform_position.x, platform_position.y, platform_position.z), \
							   Vector3(platform_position.x + translation_offset, platform_position.y, platform_position.z), \
							   animation_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, animation_time + (time_offset * 2))
	tween.repeat = true
	# warning-ignore:return_value_discarded
	tween.start()
