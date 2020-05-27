extends "../Motion.gd"

export(int) var SPEED = 70

func enter():
	.play("run")
	.chase_target()

func check_aim():
	if distance == null:
		return
	elif distance <= 30:
		emit_signal("finished", "attack")

func update(_delta):
	.chase_target()
	check_aim()
	if direction != null:
		.move(SPEED, direction)

func dead():
	emit_signal("finished", "dead")