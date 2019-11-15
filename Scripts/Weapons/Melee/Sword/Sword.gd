extends Node

func playAnim(animation):
	$AnimationPlayer.play(animation)

func _on_AttackCooldown_timeout():
	playAnim("idle")
	$AttackCooldown.stop()

func _on_Area2D_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_damage()
