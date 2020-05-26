extends Sprite

var id = 11

func _on_AttackCooldown_timeout():
	$AttackCooldown.stop()