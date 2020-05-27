	extends "StateMachine.gd"

func _ready():
	randomize()
	states_map = {
		"idle": $Idle,
		"patrol": $Patrol,
		"chase": $Chase,
		"attack": $Attack,
		"dead": $Dead
	}

func _change_state(state_name):
	if not _active:
		return
	if current_state.get_name() == "Dead" && state_name == "chase":
		return
	._change_state(state_name)