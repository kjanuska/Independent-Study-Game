extends "../States.gd"

func enter():
	return

func update(_delta):
	return

func _on_DetectionRange_body_entered(body):
	if body.get_name() == "Player":
		emit_signal("finished", "intimidate")
