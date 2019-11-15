extends "../InputParse.gd"

func enter():
	pass

func update(_delta):
	if current_weapon:
		emit_signal("finished", "transition")
	.get_input_rotation()

func handle_input(event):
	return .handle_input(event)