extends "../Motion.gd"

export(int) var SPEED = 200
var direction

var distance

func enter():
	chase_target()

func chase_target():
	var look = enemy.get_node("RayCast2D")
	look.cast_to = (enemy.target.position - enemy.position)
	look.force_raycast_update()

	if !look.is_colliding():
			direction = look.cast_to.normalized()
			distance = enemy.get_global_position().distance_to(PlayerVar.player.get_global_position())

	else:
		for scent in enemy.target.scent_trail:
			look.cast_to = (scent.position - enemy.position)
			look.force_raycast_update()

			if !look.is_colliding():
				direction = look.cast_to.normalized()
				distance = enemy.get_global_position().distance_to(PlayerVar.player.get_global_position())
				break

func check_aim():
	if distance <= 100:
		emit_signal("finished", "attack")

func update(_delta):
	chase_target()
	check_aim()
	if direction != null:
		.move(SPEED, direction)