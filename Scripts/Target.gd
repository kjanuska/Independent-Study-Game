extends Area2D

var health = 3

onready var river = get_tree().get_root().get_node("Main").get_node("River")

func take_damage():
	print("ouch")
	health -= 1
	get_parent().get_node("AnimationPlayer").play("hurt")
	if health == 0:
		get_parent().queue_free()
		river.queue_free()

