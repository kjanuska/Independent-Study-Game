extends "../Motion.gd"

export(int) var SPEED = 100
var random_direction

func enter():
	.play("run")
	patrol_time.start()
	random_direction = get_random_direction()

func update(_delta):
	.move(SPEED, random_direction)

func _on_PatrolTime_timeout():
	patrol_time.stop()
	if get_parent().current_state.name == "Patrol":
		emit_signal("finished", "idle")

func _on_ChaseArea_body_entered(body):
	if body.get_name() == "Player":
		player_near = true

func _on_ChaseArea_body_exited(body):
	if body.get_name() == "Player":
		player_near = false

func dead():
	emit_signal("finished", "dead")

