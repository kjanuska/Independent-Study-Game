extends Node2D

onready var animation = get_node("AnimationPlayer")

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		animation.play("fade")

func _on_Area2D_body_exited(body):
	if body.get_name() == "Player":
		animation.play_backwards("fade")
