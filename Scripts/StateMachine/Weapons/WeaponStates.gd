extends "StateMachine.gd"

func _ready():
	states_map = {
		"melee": $Melee,
		"ranged": $Ranged,
		"empty": $Empty
	}

func _change_state(state_name):
	if not _active:
		return
	._change_state(state_name)