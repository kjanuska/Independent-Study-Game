extends "../Motion.gd"

#speed that the player travels at
export (float) var SPEED = 300

func enter():
	speed = 0.0
	move_direction = Vector2()
	owner.get_node("AnimationPlayer").play("walk")

func update(_delta):
	var move_direction = get_input_direction()
	if not move_direction:
		emit_signal("finished", "idle")
	speed = SPEED
	.move(speed, move_direction)

