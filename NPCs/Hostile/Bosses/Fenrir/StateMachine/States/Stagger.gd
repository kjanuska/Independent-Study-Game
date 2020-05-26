extends "../Motion.gd"

func enter():
	fenrir.get_node("Hurtbox").get_node("HurtboxCollision").call_deferred("disabled", true)
	animation_player.play("stagger")
	fenrir.get_node("Timers").get_node("StaggerTimer").start()

func update(_delta):
	return

func _on_StaggerTimer_timeout():
	fenrir.get_node("Hurtbox").get_node("HurtboxCollision").disabled = false
	emit_signal("finished", "chase")
