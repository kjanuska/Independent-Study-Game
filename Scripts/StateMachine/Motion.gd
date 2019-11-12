extends "States.gd"

var move_direction = Vector2()
var speed = 0.0

func get_input_direction():
	#player direction vector
	move_direction = Vector2()
	move_direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	move_direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	if move_direction.x == 1: 
		owner.get_node("Sprite").flip_h = false 
	elif move_direction.x == -1:
		owner.get_node("Sprite").flip_h = true
	return move_direction

func move(speed_value, direction):
	var motion = direction.normalized() * speed_value
	owner.move_and_slide(motion)