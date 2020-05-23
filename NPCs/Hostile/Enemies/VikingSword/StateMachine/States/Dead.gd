extends "../Motion.gd"

func enter():
	.play("die")
	get_parent().set_physics_process(false)
	enemy.get_node("CollisionShape2D").call_deferred("disabled", "true")
