extends "StateMachine.gd"

func _ready():
	randomize()
	SignalManager.connect("player_found", self, "_player_found")
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

func _player_found():
	if current_state != $Chase:
		emit_signal("finished", "chase")