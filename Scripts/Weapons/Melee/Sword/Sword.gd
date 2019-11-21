extends Node

var id = 0

func playAnim(animation):
	$AnimationPlayer.play(animation)

func _on_Area2D_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_damage()
