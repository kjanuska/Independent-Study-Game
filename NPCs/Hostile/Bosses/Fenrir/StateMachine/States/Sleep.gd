extends Node

func enter():
	return

func update(_delta):
	return

func _on_DetectionRange_area_entered(area):
	emit_signal("finished", "chase")
