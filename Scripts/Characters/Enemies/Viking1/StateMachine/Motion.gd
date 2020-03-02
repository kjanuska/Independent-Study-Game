extends "States.gd"

onready var idle_time = owner.get_node("Timers/IdleTime")
onready var patrol_time = owner.get_node("Timers/PatrolTime")

var move_direction = Vector2()

func get_random_direction():
	move_direction = Vector2(randi() % 3 - 1, randi() % 3 - 1)
	while move_direction.length() == 0:
		move_direction = Vector2(randi() % 3 - 1, randi() % 3 - 1)
	return move_direction

func move(speed_value, direction):
	var motion = direction.normalized() * speed_value * AbilityVar.slowdown
	owner.move_and_slide(motion)

func move_along_path(distance: float) -> void:
	var start_point = position
	for i in range(path.size()):
		var distance_to_next = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			position = start_point.linear_interpolate(path[0], distance / distance_to_next)
			break
		elif distance < 0.0:
			position = path[0]
			break
		
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)

