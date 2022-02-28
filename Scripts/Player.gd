extends KinematicBody

onready var sprite : Sprite3D = $Sprite
onready var raycast : RayCast = $RayCast
onready var state_machine : Node = $StateMachine
onready var input_controller : Node

export(bool) var active = false
export(Color) var player_disabled_color = Color(1.0, 1.0, 1.0)
export(Color) var player_1_color = Color(0.172549, 0.34902, 0.815686)
export(Color) var player_2_color = Color(0.815686, 0.321569, 0.172549)

signal player_ready


# Virtual functions
func _ready() -> void:
	add_to_group("Actors")
	emit_signal("player_ready")
	
	sprite.modulate = player_disabled_color


func activate() -> void:
	self.active = true
	# Change their colour to show their status
	match self.name:
		"Player_1":
			sprite.modulate = player_1_color
		
		"Player_2":
			sprite.modulate = player_2_color
	# Start the state machine
	state_machine._start()
	state_machine.set_physics_process(true)


func deactivate() -> void:
	self.active = false
	# Change their colour to show their status
	sprite.modulate = player_disabled_color
	# Stop the state machine
	state_machine._stop()
	state_machine.set_physics_process(false)
