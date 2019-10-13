extends KinematicBody2D

var SPEED = 300
var motion = Vector2()
var moving = false
var dashing = false
var can_move = true
var can_dash = true
var player

#projectile
var shoot_speed = 20
var bullet_load = preload("res://Scenes/Projectile.tscn")

func _ready():
	player = get_node(".")

func _physics_process(delta):
	if dashing == false:
		motion.x = 0
		motion.y = 0
		moving = false
	
	if can_move:
		_get_input(delta)
	
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


func _get_input(delta):
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
	
	if Input.is_action_just_pressed("shoot"):
		_shoot_bullet(delta)
		
func _shoot_bullet(delta):
	var bullet = bullet_load.instance()
	var bullet_rotation = get_angle_to(get_global_mouse_position()) + self.get_rotation()
	bullet.set_rotation(bullet_rotation)
	bullet.set_global_position(self.get_global_position())
	get_parent().add_child(bullet)
	var direction_vector = (get_global_mouse_position() - self.get_position()).normalized()
	bullet.direction = direction_vector

func _on_DashTimer_timeout():
	SPEED = 300
	can_move = true
	dashing = false
	$DashCooldown.start()

func _on_DashCooldown_timeout():
	can_dash = true
