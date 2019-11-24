extends Area2D

export(int) var weapon_id

var overlapping = false

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		overlapping =  true

func _on_Area2D_body_exited(body):
	if body.get_name() == "Player":
		overlapping =  false

func _input(_event):
	if Input.is_action_pressed("Interact") && overlapping:
		PlayerVar.player.id = weapon_id
		SignalManager.emit_signal("weapon_changed")
		queue_free()
