extends Node2D

onready var collision = get_parent().get_node("CollisionShape2D")

func remove_collision(state):
	collision.queue_free()
