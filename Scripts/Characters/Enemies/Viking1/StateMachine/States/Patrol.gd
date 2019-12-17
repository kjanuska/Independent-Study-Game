extends "../Motion.gd"

export(int) var SPEED = 100
var direction

func _ready():
	SignalManager.connect("player_found", self, "player_found")

func enter():
#	play animation
	patrol_time.start()
	direction = get_random_direction()

func update(_delta):
	.move(SPEED, direction)

func _on_PatrolTime_timeout():
	patrol_time.stop()
	if get_parent().current_state.name == "Patrol":
		emit_signal("finished", "idle")

func player_found():
	emit_signal("finished", "chase")