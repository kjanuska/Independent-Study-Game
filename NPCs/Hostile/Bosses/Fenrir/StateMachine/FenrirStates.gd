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
		"kick_dirt": $KickDirt,
		"run_away": $RunAway,
		"stagger": $Stagger,
		"recover": $Recover
	}

func _change_state(state_name):
	if not _active:
		return
	get_parent().get_node("Label").set_text(state_name)
	._change_state(state_name)