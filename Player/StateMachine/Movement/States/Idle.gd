extends "../Motion.gd"

func enter():
	.facing_direction("idle")

func handle_input(event):
	return .handle_input(event)

func update(_delta):
	.facing_direction("idle")
	var motion = get_input_direction()
	if motion:
		emit_signal("finished", "walk")
