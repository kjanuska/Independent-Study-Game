extends KinematicBody2D

var SPEED = 300
var motion = Vector2()
var moving = false
var dashing = false
var can_move = true
var can_dash = true
var player
var distance_to_move

func _ready():
	player = get_node(".")

func _physics_process(delta):
	if dashing == false:
		motion.x = 0
		motion.y = 0
		moving = false
	
	if can_move:
		_get_input()
	
	if Input.is_action_just_pressed("space"):
		if moving && (dashing == false) && can_dash:
			SPEED *= 5
			dashing = true
			can_move = false
			can_dash = false
			$DashTimer.start()
			
	move_and_slide(motion.normalized() * SPEED)
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()


func _get_input():
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
	SPEED = 300
	can_move = true
	dashing = false
	$DashCooldown.start()

func _on_DashCooldown_timeout():
	can_dash = true
