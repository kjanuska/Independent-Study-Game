extends "../Motion.gd"

var aim_rotation

func enter():
	aim()
	.play("attack")
	attack_time.start()

func update(_delta):
	aim()

func aim():
	var aim = enemy.get_node("AimSights")
	aim.cast_to = (enemy.target.position - enemy.position)
	aim.force_raycast_update()

	if !aim.is_colliding():
			aim_rotation = aim.cast_to.normalized()
			distance = enemy.get_global_position().distance_to(PlayerVar.player.get_global_position())

	else:
		emit_signal("finished", "chase")

func _on_AttackTime_timeout():
	attack_time.stop()
	aim()
	if distance > 30:
		emit_signal("finished", "chase")
	else:
		.play("attack")
		attack_time.start()
