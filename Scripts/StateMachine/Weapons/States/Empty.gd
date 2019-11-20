extends "../InputParse.gd"

func _ready():
	SignalManager.connect("weapon_changed", self, "_change_state")

func enter():
	pass

func update(_delta):
	.get_input_rotation()

func handle_input(event):
	return .handle_input(event)

func _change_state():
	emit_signal("finished", "transition")
