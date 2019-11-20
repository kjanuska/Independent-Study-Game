extends "../States.gd"

var move_direction = Vector2()
var speed = 0.0

onready var player_animation = owner.get_node("AnimationTree").get("parameters/playback")

func get_input_direction():
	#player direction vector
	move_direction = Vector2()
	move_direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	move_direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return move_direction

func move(speed_value, direction):
	var motion = direction.normalized() * speed_value
	owner.move_and_slide(motion)