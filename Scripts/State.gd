extends Node
class_name State

onready var player_controller : Node

# warning-ignore:unused_signal
signal finished(next_state_name)


# warning-ignore:unused_argument
func enter(host: Node) -> void: # Initialize. Change the animation.
	return


# warning-ignore:unused_argument
func exit(host: Node) -> void: # Clean up. Reset values.
	return


# warning-ignore:unused_argument
func handle_input(host: Node):
	return


# warning-ignore:unused_argument
# warning-ignore:unused_argument
func update(host: Node, delta: float) -> void:
	return


# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_animation_finished(host: Node, anim_name: String) -> void:
	return
