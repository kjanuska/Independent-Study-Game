extends "../Motion.gd"

func enter():
	fenrir.get_node("DefenseRange").get_node("CollisionShape2D").disabled = false

func update(_delta):
	pass

func _on_DefenseRange_body_entered(body):
	if body.get_name() == "Player":
		emit_signal("finished", "kick_dirt")

func exit():
	fenrir.get_node("DefenseRange").get_node("CollisionShape2D").disabled = true
