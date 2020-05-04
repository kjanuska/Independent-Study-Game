extends "../Motion.gd"

export(int) var SPEED = 200

func enter():
	.chase_target()

func check_aim():
	if distance == null:
		return
	elif distance <= 100:
		emit_signal("finished", "attack")

func update(_delta):
	.chase_target()
	check_aim()
	if direction != null:
		.move(SPEED, direction)