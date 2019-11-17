extends Area2D

onready var player = get_tree().get_root().get_node("Main").get_node("Player")

export var weapon_id = 11

var overlapping = false

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		overlapping =  true

func _on_Area2D_body_exited(body):
	if body.get_name() == "Player":
		overlapping =  false

func _input(_event):
	if Input.is_action_pressed("Interact") && overlapping:
		player.id = weapon_id
		emit_signal("finished", "transition")
		queue_free()
