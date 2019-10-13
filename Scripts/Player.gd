extends KinematicBody2D

#speed that the player travels at
var SPEED = 300
#player direction vector
var motion = Vector2()
#is the player currently moving using the WASD keys
var moving = false
#is the player in the process of dashing
var dashing = false
#is the player not dashing (can't move while dashing)
var can_move = true
#used in _ready to get parent node
var player

#store preloaded scene as var
var bullet_load = preload("res://Scenes/Gun/Bullet.tscn")
#used later to assign to loaded ranged weapon scene
var ranged
#stores preloaded gun as var
var gun_load = preload("res://Scenes/Gun/Gun.tscn")

#used later to assign to loaded melee weapon scene
var melee
#store preloaded sword as var
var sword_load = preload("res://Scenes/Sword.tscn")

#0 = ranged
#1 = melee
var current_weapon = 0

#angle from character to mouse
var mouse_rotation

#equip gun as soon as the player is loaded
func _ready():
	player = get_node(".")
	player.set_z_index(1)
	_equip_ranged(gun_load)

#check for movement input, dash, move character
func _physics_process(delta):
	if dashing == false:
		motion.x = 0
		motion.y = 0
		moving = false
	
	mouse_rotation = get_angle_to(get_global_mouse_position()) + self.get_rotation()
	
	if can_move:
		_get_input()
	
	if current_weapon == 0:
		_set_weapon_rotation(ranged)
	elif current_weapon == 1:
		_set_weapon_rotation(melee)
	
	if Input.is_action_just_pressed("space"):
		if moving && dashing == false && $DashCooldown.is_stopped():
			SPEED *= 5
			dashing = true
			can_move = false
			$DashTimer.start()
			
	move_and_slide(motion.normalized() * SPEED)
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

#get input for WASD, left and right mouse buttons
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
	
	if Input.is_action_just_pressed("shoot"):
#		only equip ranged if currently equipped melee
		if current_weapon == 1:
			current_weapon = 0
			_equip_ranged(gun_load)
		_shoot_bullet()
		print(mouse_rotation)
	
	if Input.is_action_just_pressed("melee"):
#		only equip melee if currently equipped ranged
		if current_weapon == 0:
			current_weapon = 1
			_equip_melee(sword_load)
		if $SwordAttack.is_stopped():
			_melee_attack()

#equip ranged and remove melee if equiped
func _equip_ranged(ranged_load):
	if melee != null:
		melee.queue_free()
	ranged = gun_load.instance()
	player.add_child(ranged)
	ranged.set_global_position(player.get_global_position())

#equip ranged and remove melee if equiped
func _equip_melee(melee_load):
	ranged.queue_free()
	melee = melee_load.instance()
	player.add_child(melee)
	melee.set_global_position(player.get_global_position())

func _shoot_bullet():
	var bullet = bullet_load.instance()
	var bullet_rotation = mouse_rotation
	bullet.set_rotation(bullet_rotation)
	bullet.set_global_position(self.get_global_position())
	player.add_child(bullet)
	var direction_vector = (get_global_mouse_position() - self.get_position()).normalized()
	bullet.direction = direction_vector

func _melee_attack():
	print("attack")
	$SwordAttack.start()

func _set_weapon_rotation(weapon):
	var weapon_rotation = mouse_rotation
#	instead of making the weapon rotate around the center point i want to make it rotate around a circle
#	whose center is the center of the player so the weapon is off to the side and not in the middle
	weapon.set_rotation(weapon_rotation)
	if sign(weapon_rotation) == -1:
		weapon.set_z_index(-1)
	else:
		weapon.set_z_index(1)

# need to figure out how to get the sprite node of a weapon and flip that horizontally based on where the mouse cursor is
# angle is in radians, top middle is pi/2 
# the absolute value of anything to the left of pi/2 (the middle line) should be greater than pi/2
# less than pi/2 for the right
#
#	if abs(mouse_rotation) > PI/2:
#		weapon.sprite.flip_h = true
#	else:
#		weapon.sprite.flip_h = false

#timer that sets how long and how fast you dash
func _on_DashTimer_timeout():
	SPEED = 300
	can_move = true
	dashing = false
	$DashCooldown.start()

#timer for a cooldown after you dash (can't spam)
func _on_DashCooldown_timeout():
	$DashCooldown.stop()

#sword attack cooldown
func _on_SwordAttack_timeout():
	$SwordAttack.stop()
