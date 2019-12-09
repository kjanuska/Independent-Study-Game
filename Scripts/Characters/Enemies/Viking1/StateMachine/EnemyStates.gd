extends "StateMachine.gd"

func _ready():
	states_map = {
		"idle": $Idle,
		"patrol": $Patrol,
		"chase": $Chase,
		"attack": $Attack
	}

func _change_state(state_name):
	if not _active:
		return
	._change_state(state_name)
