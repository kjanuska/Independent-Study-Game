extends Area2D

export(int) var right_limit
export(int) var left_limit

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		PlayerVar.player.camera_limit(right_limit, left_limit)
