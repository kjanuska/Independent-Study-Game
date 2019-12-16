extends "../Motion.gd"

export(int) var SPEED = 100
var direction

func enter():
#	play animation
	print("patrol")
	patrol_time.start()
	direction = get_random_direction()
	print(direction)

func update(_delta):
	.move(SPEED, direction)

func _on_PatrolTime_timeout():
	patrol_time.stop()
	emit_signal("finished", "idle")