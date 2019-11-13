extends Node

func playAnim(animation):
	print("attack")
	$AnimationPlayer.play(animation)

func _on_MeleeAttack_timeout():
	playAnim("idle")
	$MeleeAttack.stop()

func _on_Area2D_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_damage()
