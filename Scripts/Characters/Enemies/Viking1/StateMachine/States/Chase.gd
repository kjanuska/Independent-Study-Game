extends "../Motion.gd"

export(int) var SPEED = 200
var direction

func enter():
	pass

func update(_delta):
	direction = Vector2(PlayerVar.player.position.x - owner.position.x, PlayerVar.player.position.y - owner.position.y)
	.move(SPEED, direction)

func _on_StopChaseArea_body_exited(body):
	if body.get_name() == "Player":
		print("lost")
		emit_signal("finished", "idle")

func _on_AttackRange_body_entered(body):
	if body.get_name() == "Player":
		emit_signal("finished", "attack")
