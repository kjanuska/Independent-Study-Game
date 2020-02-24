extends "../Motion.gd"

var direction

export(int) var SPEED = 200.0

func enter():
	pass

func update(_delta):
	var walk_distance = character_speed * delta
	
	move_along_path(walk_distance)

func _on_StopChaseArea_body_exited(body):
	if body.get_name() == "Player":
		emit_signal("finished", "idle")

func _on_AttackRange_body_entered(body):
	if body.get_name() == "Player":
		emit_signal("finished", "attack")