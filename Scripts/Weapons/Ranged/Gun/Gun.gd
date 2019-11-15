extends Sprite

func _on_AttackCooldown_timeout():
	$AttackCooldown.stop()