extends Sprite

func _on_ShotCooldown_timeout():
	$ShotCooldown.stop()
