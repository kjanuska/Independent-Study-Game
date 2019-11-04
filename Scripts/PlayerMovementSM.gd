extends StateMachine

func _ready():
	add_state("idle")
	add_state("walk")
	add_state("dash")
	call_deferred("set_state", states.idle)

func _input(event):
	if [states.walk].has(state):
		if event.is_action_pressed("dash"):
			player.dash()

func _state_logic(delta):
	player.handle_move_input()
	player.apply_movement()

func _get_transtion(delta):
	match state:
		states.idle:
			if player.motion.x > 0 || player.motion.y > 0:
				print(player.motion)
				return states.walk
		states.walk:
			if player.motion.x == 0 && player.motion.y == 0:
				return states.idle
		states.dash:
			if player.get_node("DashCooldown").is_stopped():
				print("stopped")
	
	return null

func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			pass
#			animation for idle
		states.walk:
			pass
#			animation for walk

func _exit_state(old_state, new_state):
	pass	