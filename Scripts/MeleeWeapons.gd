extends Area2D

func _on_MeleeAttack_timeout():
	$MeleeAttack.stop()
