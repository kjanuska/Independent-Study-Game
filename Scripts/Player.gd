extends Node2D

var SPEED = 50
var motion = Vector2()

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		motion.x += SPEED
	
	if Input.is_action_pressed("ui_left"):
		motion.x -= SPEED
