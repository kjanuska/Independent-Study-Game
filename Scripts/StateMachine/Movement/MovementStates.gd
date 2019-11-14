extends "StateMachine.gd"

func _ready():
	states_map = {
		"idle": $Idle,
		"walk": $Walk,
		"dash": $Dash
	}

func _change_state(state_name):
	if not _active:
		return
	if state_name in ["dash"]:
		states_stack.push_front(states_map[state_name])
	if state_name == "dash" and current_state == $Walk:
		$Dash.enter()
	._change_state(state_name)
