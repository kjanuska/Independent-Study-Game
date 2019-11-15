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
	if state_name in ["transition"]:
		emit_signal("weapon_changed", owner.id)
	._change_state(state_name)