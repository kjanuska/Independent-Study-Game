extends Area2D

var health = 3

func take_damage():
	print("ouch")
	health -= 1
	get_parent().get_node("AnimationPlayer").play("hurt")
	if health == 0:
		get_parent().queue_free()

