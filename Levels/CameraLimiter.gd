extends Area2D

export(int) var top_limit
export(int) var bottom_limit
export(int) var right_limit
export(int) var left_limit 

func _on_CameraLimiter_body_entered(body):
	if body.get_name() == "Player":
		body.get_node("Camera").limit_top = top_limit
		body.get_node("Camera").limit_bottom = bottom_limit
		body.get_node("Camera").limit_right = right_limit
		body.get_node("Camera").limit_left = left_limit
