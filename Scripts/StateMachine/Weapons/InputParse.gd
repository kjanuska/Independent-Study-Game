extends "../States.gd"

var current_weapon = null
var melee = null
var ranged = null

var mouse_rotation

func get_input_rotation():
	mouse_rotation = owner.get_input_rotation()
	return mouse_rotation