extends "../Motion.gd"

export(int) var SPEED = 200
var direction

func enter():
	print("chase")

func update(_delta):
	direction = owner.get_angle_to_player()
	.move(SPEED, direction)

func _on_Area2D_body_exited(body):
	emit_signal("finished", "idle")
