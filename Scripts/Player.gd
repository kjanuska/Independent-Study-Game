extends KinematicBody2D

var SPEED = 300
var motion = Vector2()
var moving = false
var can_move = true
var can_dash = true
var player

func _ready():
	player = get_node(".")

func _physics_process(delta):
	motion.x = 0
	motion.y = 0
	moving = false
	
	_get_input()

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
	
	if Input.is_action_just_pressed("space"):
		if moving && can_dash:
			can_move = false
			can_dash = false
			player.visible = not player.visible
			var target_position = player.get_position() + ((motion.normalized()) * 150)
			player.position.x = target_position.x
			player.position.y = target_position.y
			$DashTimer.start()

func _on_DashTimer_timeout():
	player.visible = not player.visible
	can_move = true
	$DashCooldown.start()

func _on_DashCooldown_timeout():
	can_dash = true
