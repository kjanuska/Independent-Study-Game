extends StateMachine

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
	#speed that the player travels at
	var SPEED = 300
	#player direction vector
	var motion = Vector2()
	
func apply_movement():
	move_and_slide(motion.normalized() * SPEED)
#	motion.x = 0
#	motion.y = 0

#get input for WASD, left and right mouse buttons
func handle_move_input():
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		moving = true
	
	if Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		moving = true
	
	if Input.is_action_pressed("ui_up"):
		motion.y = -SPEED
		moving = true
	
	if Input.is_action_pressed("ui_down"):
		motion.y = SPEED
		moving = true
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()