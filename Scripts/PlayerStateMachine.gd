extends StateMachine

func _state_logic(delta):
	add_state("idle")
	add_state("walk")
	add_state("shoot")
	add_state("melee")
	add_state("dash")
	call_deferred("set_state", states.sleep)

func _get_transtion(delta):
	return null

func _enter_state(new_state, old_state):
	pass

func _exit_state(old_state, new_state):
	pass	