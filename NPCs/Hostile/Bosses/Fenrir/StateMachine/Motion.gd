extends "States.gd"

var direction
var distance
onready var fenrir = get_parent().get_parent()

func move(speed_value, direction):
	var motion = direction.normalized() * speed_value * AbilityVar.slowdown
	owner.move_and_slide(motion)

func get_direction(target):
	return (target.position - fenrir.position).normalized()

func get_distance():
	return fenrir.get_global_position().distance_to(PlayerVar.player.get_global_position())

func chase_target():
	var look = fenrir.get_node("RayCast2D")
	look.cast_to = (fenrir.target.position - fenrir.position)
	look.force_raycast_update()

	if !look.is_colliding():
			direction = look.cast_to.normalized()
			distance = fenrir.get_global_position().distance_to(PlayerVar.player.get_global_position())

	else:
		for scent in fenrir.target.scent_trail:
			look.cast_to = (scent.position - fenrir.position)
			look.force_raycast_update()

			if !look.is_colliding():
				direction = look.cast_to.normalized()
				distance = fenrir.get_global_position().distance_to(PlayerVar.player.get_global_position())
				break