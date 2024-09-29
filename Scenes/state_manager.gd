extends Node

class_name StateManager

var current_state  # Jelenlegi állapot
var states = {}  # Az összes állapot tárolója

# Állapot hozzáadása a managerhez
func add_state(state_name: String, state_instance):
	states[state_name] = state_instance

# Állapot váltás
func set_state(state_name: String):
	if current_state:
		current_state.exit_state()  # Előző állapotból kilépünk
	current_state = states[state_name]
	current_state.enter_state()  # Belépünk az új állapotba

# Az aktuális állapot frissítése
func update_state(delta, player):
	if current_state:
		current_state.update_state(delta, player)
