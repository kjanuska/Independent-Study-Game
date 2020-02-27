extends "../Motion.gd"

var direction

export(int) var SPEED = 200.0

func enter():
	PlayerVar.chasing = true

func _on_StopChaseArea_body_exited(body):
	if body.get_name() == "Player":
		PlayerVar.chasing = false
		emit_signal("finished", "idle")

func _on_AttackRange_body_entered(body):
	if body.get_name() == "Player":
		PlayerVar.chasing = false
		emit_signal("finished", "attack")