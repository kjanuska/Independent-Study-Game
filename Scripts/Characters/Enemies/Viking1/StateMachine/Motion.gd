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