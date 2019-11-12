extends Area2D

onready var player = get_tree().get_root().get_node("Main").get_node("Player")

export var weapon_id = 11

var is_colliding = false

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		is_colliding =  true

func _on_Area2D_body_exited(body):
	if body.get_name() == "Player":
		is_colliding =  false

func _input(_event):
	if Input.is_action_pressed("Interact") && is_colliding:
		player.pickup(weapon_id)
		queue_free()
