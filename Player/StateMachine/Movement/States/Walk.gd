extends "../Motion.gd"

#speed that the player travels at
export (float) var SPEED = 300

onready var dash_cooldown = owner.get_node("DashCooldown")

var walk_anim

func enter():
	.facing_direction("walk")

func handle_input(event):
	if event.is_action_pressed("dash") && dash_cooldown.is_stopped():
		emit_signal("finished", "dash")

func update(_delta):
	.facing_direction("walk")
	var move_direction = get_input_direction()
	if not move_direction:
		emit_signal("finished", "idle")
	.move(SPEED, move_direction)