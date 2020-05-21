extends "../Motion.gd"

func enter():
	PlayerVar.scent_visible = true
	fenrir.get_node("Timers").get_node("IntimidateTimer").start()

func update(_delta):
	pass

func exit():
	PlayerVar.scent_visible = false
	fenrir.get_node("DetectionRange").get_node("CollisionShape2D").call_deferred("set_disabled", true)

func _on_IntimidateTimer_timeout():
	emit_signal("finished", "circle")
