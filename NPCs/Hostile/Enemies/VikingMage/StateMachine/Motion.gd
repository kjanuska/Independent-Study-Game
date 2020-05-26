extends "States.gd"

onready var idle_time = owner.get_node("Timers/IdleTime")
onready var patrol_time = owner.get_node("Timers/PatrolTime")
onready var enemy = self.get_parent().get_parent()

var distance
var direction

func get_random_direction():
	var move_direction = Vector2()
	move_direction = Vector2(randi() % 3 - 1, randi() % 3 - 1)
	while move_direction.length() == 0:
		move_direction = Vector2(randi() % 3 - 1, randi() % 3 - 1)
	return move_direction

func move(speed_value, direction):
	var motion = direction.normalized() * speed_value * enemy.slowdown
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