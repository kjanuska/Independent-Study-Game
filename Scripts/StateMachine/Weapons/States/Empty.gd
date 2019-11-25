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
	if PlayerVar.current_weapon_id != null:
		emit_signal("finished", "transition")
	else:
		emit_signal("finished", "empty")
