extends Area2D

var health = 3

export(NodePath) var river
export(NodePath) var falling_log

func take_damage():
	health -= 1
	get_parent().get_node("AnimationPlayer").play("hurt")
	if health == 0:
		get_parent().queue_free()
		get_node(river).get_node("FallTimer").start()
		get_node(falling_log).get_node("AnimationPlayer").play("fall")
