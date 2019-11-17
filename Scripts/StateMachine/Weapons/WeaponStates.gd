extends "StateMachine.gd"

func _ready():
	states_map = {
		"melee": $Melee,
		"ranged": $Ranged,
		"empty": $Empty,
		"transition": $Transition
	}

func _change_state(state_name):
	if not _active:
		return
	._change_state(state_name)