extends StaticBody2D

func _on_FallTimer_timeout():
	get_node("Flowing").hide()
