extends "../Motion.gd"

func enter():
	.play("die")
	enemy.get_node("CollisionShape2D").call_deferred("disabled", "true")

func dead():
	pass