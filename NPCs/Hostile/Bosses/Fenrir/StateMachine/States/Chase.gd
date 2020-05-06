extends "../Motion.gd"

export(int) var SPEED = 250

func enter():
	.chase_target()

func check_aim():
	if distance == null:
		return
	elif distance <= 50:
		emit_signal("finished", "attack")

func update(_delta):
	.chase_target()
	check_aim()
	if direction != null:
		.move(SPEED, direction)