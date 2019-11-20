extends "../Motion.gd"

func enter():
	player_animation.travel("idle")

func handle_input(event):
	return .handle_input(event)

func update(_delta):
	var motion = get_input_direction()
	if motion:
		emit_signal("finished", "walk")
