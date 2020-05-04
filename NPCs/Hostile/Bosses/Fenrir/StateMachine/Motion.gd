extends "States.gd"

onready var enemy = self.get_parent().get_parent()

func move(speed_value, direction):
	var motion = direction.normalized() * speed_value * AbilityVar.slowdown
	owner.move_and_slide(motion)