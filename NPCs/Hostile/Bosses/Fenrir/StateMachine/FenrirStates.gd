extends "StateMachine.gd"

func _ready():
	randomize()
	states_map = {
		"sleep": $Sleep,
		"chase": $Chase,
		"attack": $Attack,
		"charge": $Charge,
		"circle": $Circle,
		"intimidate": $Intimidate,
		"kickdirt": $KickDirt,
		"runaway": $RunAway
	}

func _change_state(state_name):
	if not _active:
		return
	._change_state(state_name)