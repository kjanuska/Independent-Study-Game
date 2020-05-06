extends "States.gd"

onready var enemy = get_parent().get_parent()

var direction
var distance

func move(speed_value, direction):
	var motion = direction.normalized() * speed_value * AbilityVar.slowdown
	owner.move_and_slide(motion)

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