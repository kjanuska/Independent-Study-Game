extends KinematicBody2D

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		SignalManager.emit_signal("player_found")

func get_angle_to_player():
	return get_angle_to(PlayerVar.player.rotation + self.rotation)