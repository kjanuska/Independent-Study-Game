extends KinematicBody2D


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

# weapon currently in hand
var current_weapon

# specific weapon for each type
# melee in 1s
# 0 = sword
# 
# ranged in 10s
# 10 = bow
# 11 = gun
var equipped_melee_id
var equipped_melee
var equipped_ranged_id
var equipped_ranged
var equipped_ammo
var ammo_speed

#angle from character to mouse
var mouse_rotation
# 0 = left
# 1 = right
var side = 0

# check how long shoot button has been pressed
var count = 0

# equip gun as soon as the player is loaded
func _ready():
	player = get_node(".")
	player.set_z_index(1)

#check for movement input, dash, move character
func _physics_process(_delta):	
	mouse_rotation = get_angle_to(get_global_mouse_position()) + self.get_rotation()
	
	if can_move:
		get_input()
	
	if current_weapon != null:
		set_weapon_rotation()
	
	if Input.is_action_just_pressed("space"):
		if moving && dashing == false && $DashCooldown.is_stopped():
			$DashTimer.start()
			
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

#get input for WASD, left and right mouse buttons
func get_input():	
	if Input.is_action_pressed("shoot"):
#		only equip ranged if currently equipped melee
		if equipped_ranged != null:
			if current_weapon == melee:
				equip(equipped_ranged_id)
			count += 1
			if equipped_ranged == bow_load:
				if count >= 80:
					$Charged.popup()
			else:
				shoot_weapon(equipped_ammo, ammo_speed)
				count = 0
		
	if Input.is_action_just_released("shoot") && equipped_ranged == bow_load:
		shoot_charged()
		
	if Input.is_action_just_pressed("melee"):
#		only equip melee if currently equipped ranged
		if equipped_melee != null:
			if current_weapon == ranged:
				current_weapon = melee
				equip(equipped_melee_id)
			if melee_attack_cooldown.is_stopped():
				melee_attack()

func pickup(id):
	if current_weapon != null:
		if current_weapon == melee:
			melee.queue_free()
		elif current_weapon == ranged:
			ranged.queue_free()
	equip(id)

func equip(id):
	if id != null:
		if id < 10:
			match id:
				0:
					equipped_melee = sword_load
					equipped_melee_id = 0
			if is_instance_valid(ranged):
				ranged.queue_free()
			melee = equipped_melee.instance()
			player.add_child(melee)
			melee.set_global_position(player.get_global_position())
			melee_attack_cooldown = melee.get_node("MeleeAttack")
			current_weapon = melee
		elif id >= 10:
			match id:
				10:
					equipped_ranged = bow_load
					equipped_ranged_id = 10
					equipped_ammo = arrow_load
				11:
					equipped_ranged = gun_load
					equipped_ranged_id = 11
					equipped_ammo = bullet_load
					ammo_speed = 3000
			if is_instance_valid(melee):
				melee.queue_free()
			ranged = equipped_ranged.instance()
			player.add_child(ranged)
			ranged.set_global_position(player.get_global_position())
			shot_cooldown = ranged.get_node("ShotCooldown")
			current_weapon = ranged

func shoot_weapon(ammo_load, speed):
	if shot_cooldown.is_stopped():
		var projectile = ammo_load.instance()
		var projectile_rotation = mouse_rotation
		projectile.set_rotation(projectile_rotation)
		projectile.set_global_position(ranged.get_global_position())
		player.add_child(projectile)
		var direction_vector = (get_global_mouse_position() - self.get_position()).normalized()
		projectile.direction = direction_vector
		projectile.set_speed(speed)
		shot_cooldown.start()

func shoot_charged():
	if count >= 80:
		ammo_speed = 3000
		$Charged.hide()
		shoot_weapon(equipped_ammo, ammo_speed)
		count = 0
	elif count < 80:
		ammo_speed = 1000
		shoot_weapon(equipped_ammo, ammo_speed)
		count = 0

func melee_attack():
	melee.playAnim("attack")
	melee_attack_cooldown.start()

func set_weapon_rotation():
	current_weapon.set_rotation(mouse_rotation)
	if sign(mouse_rotation) == -1:
		current_weapon.set_z_index(-1)
	else:
		current_weapon.set_z_index(1)

	if side == 0:
		if abs(mouse_rotation) <= PI/4:
			side = 1
		else:
			current_weapon.position.x = -15
	elif side == 1:
		if abs(mouse_rotation) >= (3 * PI)/4:
			side = 0
		else:
			current_weapon.position.x = 15
