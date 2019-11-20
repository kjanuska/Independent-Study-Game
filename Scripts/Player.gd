extends KinematicBody2D

#used in _ready to get parent node
var player

var attack_cooldown
var weapon_animation_player

# weapon currently in hand
var current_weapon
var previous_weapon_id
var charge_ranged

var id

var ammo
var ammo_speed

#angle from character to mouse
var mouse_rotation

# check how long shoot button has been pressed
var count = 0

# equip gun as soon as the player is loaded
func _ready():
	player = get_node(".")
	player.set_z_index(1)

func _physics_process(_delta):	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func get_input_rotation():
	var is_flipped
	mouse_rotation = get_angle_to(get_global_mouse_position()) + self.get_rotation()
	if abs(mouse_rotation) < PI/2:
		is_flipped = false
	if abs(mouse_rotation) > PI/2:
		is_flipped = true
	get_node("Sprite").flip_h = is_flipped
	if current_weapon:
			current_weapon.get_node("Sprite").flip_v = is_flipped
	return mouse_rotation
"""
below is old rotation code that rotated weapon around a point in the player's hand depending on which side
the player was facing

	if sign(mouse_rotation) == -1:
		current_weapon.set_z_index(-1)
	else:
		current_weapon.set_z_index(1)

	if side == 0:
		if abs(mouse_rotation) <= PI/4:
			side = 1
		else:
			current_weapon.position.x = -15
			current_weapon.position.y = 5
			get_node("Sprite").flip_h = true
	elif side == 1:
		if abs(mouse_rotation) >= (3 * PI)/4:
			side = 0
		else:
			current_weapon.position.x = 10
			current_weapon.position.y = 5
			get_node("Sprite").flip_h = false
"""

func equip():
	current_weapon = current_weapon.instance()
	player.add_child(current_weapon)
	current_weapon.set_global_position(player.get_position())
	attack_cooldown = current_weapon.get_node("AttackCooldown")
	weapon_animation_player = current_weapon.get_node("AnimationPlayer")

func shoot_weapon():
	if attack_cooldown.is_stopped():
		weapon_animation_player.play("attack")
		var projectile = ammo.instance()
		var projectile_rotation = mouse_rotation
		projectile.set_rotation(projectile_rotation)
		projectile.set_global_position(current_weapon.get_global_position())
		player.add_child(projectile)
		var direction_vector = (get_global_mouse_position() - self.get_position()).normalized()
		projectile.direction = direction_vector
		projectile.set_speed(ammo_speed)
		attack_cooldown.start()

func shoot_charged():
	weapon_animation_player.play("attack")
	if count == 80:
		ammo_speed = 3000
		shoot_weapon()
		count = 0
	elif count < 80:
		ammo_speed = 1000
		shoot_weapon()
		count = 0

func melee_attack():
	current_weapon.playAnim("attack")
	attack_cooldown.start()
