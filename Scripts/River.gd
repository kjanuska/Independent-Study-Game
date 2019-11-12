extends Node2D

func _ready():
	$"Flowing2".queue_free()

func _on_FallTimer_timeout():
	$"Flowing2".queue_free()
	$FallTimer.stop()

func _on_Spikes_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_damage()
