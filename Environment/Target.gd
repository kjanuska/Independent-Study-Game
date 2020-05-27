extends Area2D

var health = 3

export(NodePath) var river
export(NodePath) var falling_log

func take_damage(damage):
	health -= damage
	get_parent().get_node("AnimationPlayer").play("hurt")
	if health <= 0:
		get_node(river).get_node("FallTimer").start()
		get_node(falling_log).get_node("AnimationPlayer").play("fall")
		get_parent().queue_free()
