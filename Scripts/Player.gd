extends KinematicBody2D

var SPEED = 300
var motion = Vector2()
var moving = false
var can_move = true
var can_dash = true
var player
var dashing = false
var target_position

func _ready():
	player = get_node(".")

func _physics_process(delta):
	motion.x = 0
	motion.y = 0
	moving = false
	
	_get_input()
	
	if dashing:
#		move player smootly from current position to target position
			dashing = false
	
	if Input.is_action_just_pressed("space"):
		if moving && can_dash:
			dashing = true
			can_move = false
			can_dash = false
			target_position = player.get_position() + ((motion.normalized()) * 150)
			$DashTimer.start()
			
	move_and_slide(motion.normalized() * SPEED)
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()


func _get_input():
	if can_move:
		if Input.is_action_pressed("ui_right"):
			motion.x = SPEED
			moving = true
		
		if Input.is_action_pressed("ui_left"):
			motion.x = -SPEED
			moving = true
		
		if Input.is_action_pressed("ui_up"):
			motion.y = -SPEED
			moving = true
		
		if Input.is_action_pressed("ui_down"):
			motion.y = SPEED
			moving = true
	

func _on_DashTimer_timeout():
	can_move = true
	$DashCooldown.start()

func _on_DashCooldown_timeout():
	can_dash = true
