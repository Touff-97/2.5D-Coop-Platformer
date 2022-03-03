extends Node
class_name StateMachine

export(NodePath) onready var default_state = get_node(default_state)
export(NodePath) onready var kinematic_body = get_node(kinematic_body)

export(Vector3) var velocity = Vector3.ZERO

var state_stack : Array = []
var current_state : State setget set_current_state, get_current_state
var state_map : Dictionary = {}


func _ready() -> void:
	set_physics_process(false)


func _start() -> void:
	var children_nodes : Array = get_children()
	# Add states into the state map dictionary
	for child in children_nodes:
		if child is State:
			# warning-ignore:return_value_discarded
			add_state_to_map(child)
			child.player_controller = kinematic_body.input_controller
		else:
			push_error("StateMachine child " + child.name + " is not a state.")
	
	state_stack.push_front(state_map[default_state.name])
	current_state = state_stack[0]
	change_state(default_state.name)


func _stop() -> void:
	var children_nodes : Array = get_children()
	for child in children_nodes:
		if child is State:
			child.player_controller = null
			child.disconnect("finished", self, "change_state")
	state_map = {}


func _physics_process(delta: float) -> void:
	handle_input() # Handle input from the current state
	current_state.update(self, delta)


func handle_input() -> void:
	current_state.handle_input(self)


func add_state_to_map(state: State) -> bool:
	if not state_map.has(state.name):
		state_map[state.name] = state
		if state.connect("finished", self, "change_state") == null:
			push_error(state.name + " failed to connect to state finished.")
		return true
	else:
		push_error("State already exists in state stack for " + state.name)
		return false


func change_state(state_name: String) -> void:
	if state_map.has(state_name):
		# Transition out off the current state
		if current_state != null:
			current_state.exit(self)
		# Transition into the next state
		current_state = state_map[state_name]
		current_state.enter(self)
	else:
		push_error("StateMachine does not contain state " + state_name)


# Setter Getter
func set_current_state(new_value: State) -> void:
	current_state = new_value


func get_current_state() -> State:
	return current_state
