extends Node2D

var id = 10

func _on_AttackCooldown_timeout():
	$AttackCooldown.stop()
