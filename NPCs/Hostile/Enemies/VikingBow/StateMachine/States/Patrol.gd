extends "../Motion.gd"

export(int) var SPEED = 100
var random_direction

func _ready():
	SignalManager.connect("player_found", self, "player_found")

func enter():
	patrol_time.start()
	random_direction = get_random_direction()

func update(_delta):
	.move(SPEED, random_direction)

func _on_PatrolTime_timeout():
	patrol_time.stop()
	if get_parent().current_state.name == "Patrol":
		emit_signal("finished", "idle")

func player_found():
	emit_signal("finished", "chase")

func _on_ChaseArea_body_entered(body):
	if body.get_name() == "Player":
		SignalManager.emit_signal("player_found")
