extends Node
class_name StateManager

var current_state
var states = {}

func add_state(state_name: String, state_instance):
	states[state_name] = state_instance

func set_state(state_name: String):
	if current_state:
		current_state.exit_state()
	current_state = states.get(state_name)
	current_state.enter_state()

func update_state(delta):
	if current_state:
		current_state.update_state(delta)
