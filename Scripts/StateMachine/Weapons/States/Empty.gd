extends "../InputParse.gd"

func enter():
	pass

func update(_delta):
	if current_weapon:
		if current_weapon == ranged:
			emit_signal("finished", "ranged")
		if current_weapon == melee:
			emit_signal("finished", "melee")
	.get_input_rotation()

func handle_input(event):
	return .handle_input(event)