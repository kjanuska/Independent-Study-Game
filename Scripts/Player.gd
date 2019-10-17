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
var arrow_load = preload("res://Scenes/Bow/Arrow.tscn")
#used later to assign to loaded ranged weapon scene
var ranged
#stores preloaded gun as var
var gun_load = preload("res://Scenes/Gun/Gun.tscn")
var shot_cooldown
var bow_load = preload("res://Scenes/Bow/Bow.tscn")

#used later to assign to loaded melee weapon scene
var melee
#store preloaded sword as var
var sword_load = preload("res://Scenes/Sword.tscn")
var melee_attack_cooldown

# 0 = ranged
# 1 = melee
var current_weapon_type = 0

# specific weapon for each type
# melee in 0s, ranged in 10s
# 0 = sword
# 10 = bow
# 11 = gun
var current_melee_id = 0
var current_melee
var current_ranged_id = 10
var current_ranged

#angle from character to mouse
var mouse_rotation
# 0 = left
# 1 = right
var side = 0

# check how long shoot button has been pressed
var count = 0

#equip gun as soon as the player is loaded
func _ready():
	equip(0)
	equip(10)
	player = get_node(".")
	player.set_z_index(1)
	_equip_ranged(current_ranged)

#check for movement input, dash, move character
func _physics_process(delta):
	if dashing == false:
		motion.x = 0
		motion.y = 0
		moving = false
	
	mouse_rotation = get_angle_to(get_global_mouse_position()) + self.get_rotation()

	if can_move:
		_get_input()
	
	if current_weapon_type == 0:
		_set_weapon_rotation(ranged)
	elif current_weapon_type == 1:
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
	
	if Input.is_action_pressed("shoot"):
#		only equip ranged if currently equipped melee
		if current_weapon_type == 1:
			current_weapon_type = 0
			_equip_ranged(bow_load)
		count += 1
		if current_ranged == bow_load:
			if count >= 80:
				$Charged.popup()
		else:
			_shoot_weapon(arrow_load)
	
	if Input.is_action_just_released("shoot") && current_ranged == bow_load:
		shoot_charged()
	
	if Input.is_action_just_pressed("melee"):
#		only equip melee if currently equipped ranged
		if current_weapon_type == 0:
			current_weapon_type = 1
			_equip_melee(sword_load)
		if melee_attack_cooldown.is_stopped():
			_melee_attack()

#equip ranged and remove melee if equiped
func _equip_ranged(ranged_load):
	if melee != null:
		melee.queue_free()
	ranged = ranged_load.instance()
	player.add_child(ranged)
	ranged.set_global_position(player.get_global_position())
	shot_cooldown = ranged.get_node("ShotCooldown")

#equip ranged and remove melee if equiped
func _equip_melee(melee_load):
	ranged.queue_free()
	melee = melee_load.instance()
	player.add_child(melee)
	melee.set_global_position(player.get_global_position())
	melee_attack_cooldown = melee.get_node("MeleeAttack")

func equip(id):
	if id < 10:
		match id:
			0:
				current_melee = sword_load
	elif id >= 10:
		match id:
			10:
				current_ranged = bow_load
			11:
				current_ranged = gun_load

func _shoot_weapon(ammo_load):
	if shot_cooldown.is_stopped():
		var projectile = ammo_load.instance()
		var projectile_rotation = mouse_rotation
		projectile.set_rotation(projectile_rotation)
		projectile.set_global_position(ranged.get_global_position())
		player.add_child(projectile)
		var direction_vector = (get_global_mouse_position() - self.get_position()).normalized()
		projectile.direction = direction_vector
		shot_cooldown.start()

func shoot_charged():
	if count >= 80:
		$Charged.hide()
		count = 0
	elif count < 80:
		print("short shot")
		_shoot_weapon(arrow_load)
		count = 0

func _melee_attack():
	print("attack")
	melee_attack_cooldown.start()

func _set_weapon_rotation(weapon):
	weapon.set_rotation(mouse_rotation)
	if sign(mouse_rotation) == -1:
		weapon.set_z_index(-1)
	else:
		weapon.set_z_index(1)

	if side == 0:
		if abs(mouse_rotation) <= PI/4:
			side = 1
		else:
			weapon.position.x = -15
	elif side == 1:
		if abs(mouse_rotation) >= (3 * PI)/4:
			side = 0
		else:
			weapon.position.x = 15


#timer that sets how long and how fast you dash
func _on_DashTimer_timeout():
	SPEED = 300
	can_move = true
	dashing = false
	$DashCooldown.start()

#timer for a cooldown after you dash (can't spam)
func _on_DashCooldown_timeout():
	$DashCooldown.stop()
