extends "../Motion.gd"

var aim_rotation

func enter():
	aim()

func update(_delta):
	aim()
	if distance > 50:
		emit_signal("finished", "chase")

func aim():
	var aim = fenrir.get_node("AimSights")
	aim.cast_to = (fenrir.target.position - fenrir.position)
	aim.force_raycast_update()

	if !aim.is_colliding():
			aim_rotation = aim.cast_to.normalized()
			distance = fenrir.get_global_position().distance_to(PlayerVar.player.get_global_position())

	else:
		emit_signal("finished", "chase")

