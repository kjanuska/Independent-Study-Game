extends "../Motion.gd"

export(int) var SPEED = 200
var direction

func enter():
	owner.chasing = true

func update(_delta):
#	direction = Vector2(PlayerVar.player.position.x - owner.position.x, PlayerVar.player.position.y - owner.position.y)
#	.move(SPEED, direction)
	var move_distance = SPEED * _delta
	pass

func _on_StopChaseArea_body_exited(body):
	if body.get_name() == "Player":
		owner.chasing = false
		emit_signal("finished", "idle")

func _on_AttackRange_body_entered(body):
	if body.get_name() == "Player":
		owner.chasing = false
		emit_signal("finished", "attack")
