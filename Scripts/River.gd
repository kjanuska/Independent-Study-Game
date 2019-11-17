extends Node2D

var overlapping = false
var entity

func _ready():
	$"Flowing2".queue_free()

func _physics_process(delta):
	if overlapping:
		entity.take_damage()

func _on_FallTimer_timeout():
	$"Flowing2".queue_free()
	$FallTimer.stop()

func _on_Spikes_area_entered(area):
	if area.is_in_group("hurtbox"):
		overlapping = true
		entity = area

func _on_Spikes_area_exited(area):
	overlapping = false
	entity = null
