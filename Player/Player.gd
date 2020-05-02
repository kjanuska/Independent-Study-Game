extends KinematicBody2D

#used in _ready to get parent node
var player
var player_animation

var melee_cooldown
var ranged_cooldown
var ability_cooldown
var timer
var weapon_animation_player
var ability_animation_player
var weapon_anim_finished = true
var ability_anim_finished = true
var is_flipped

# weapon currently in hand
var current_weapon
var current_ability

var ammo
var ammo_speed

#angle from character to mouse
var mouse_rotation

# check how long shoot button has been pressed
var count = 0

var camera

const scent_scene = preload("res://Player/Effects/Scent.tscn")

var scent_trail = []

var level

# equip gun as soon as the player is loaded
func _ready():
	player = get_node(".")
	player_animation = $AnimationTree.get("parameters/playback")
	melee_cooldown = $WeaponTimers/MeleeCooldown
	ranged_cooldown = $WeaponTimers/RangedCooldown
	ability_cooldown = $AbilityCooldown
	camera = $Camera
	$ScentTimer.connect("timeout", self, "add_scent")
	level = get_tree().get_current_scene()
	

func _physics_process(_delta):
	$Label.set_text(String(Vector2(floor(player.get_global_position().x), floor(player.get_global_position().y))))
	write_movement_path()
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_just_pressed("ui_focus_next"):
		$RadialMenu.show()
		Engine.time_scale = 0.02
	if Input.is_action_just_released("ui_focus_next"):
		$RadialMenu.hide()
		Engine.time_scale = 1

func get_input_rotation():
	mouse_rotation = get_angle_to(get_global_mouse_position()) + self.get_rotation()
	if abs(mouse_rotation) < PI/2:
		is_flipped = false
	if abs(mouse_rotation) > PI/2:
		is_flipped = true
	get_node("Sprite").flip_h = is_flipped
	if current_weapon != null:
		current_weapon.get_node("Sprite").flip_v = is_flipped
	return mouse_rotation

func add_scent():
	var scent = scent_scene.instance()
	scent.player = player
	scent.set_global_position(player.get_global_position())

	level.get_node("World").get_node("effects").add_child(scent)
	scent_trail.push_front(scent)

func equip_ability():
	current_ability = current_ability.instance()
	player.add_child(current_ability)
	current_ability.set_global_position(player.get_global_position())
	timer = current_ability.time
	ability_animation_player = current_ability.get_node("AnimationPlayer")

func equip():
	current_weapon = current_weapon.instance()
	player.add_child(current_weapon)
	current_weapon.set_global_position(player.get_global_position())
	current_weapon.set_rotation(get_input_rotation())
	timer = current_weapon.time
	weapon_animation_player = current_weapon.get_node("AnimationPlayer")

func shoot_weapon():
	weapon_animation_player.play("attack")
	var projectile = ammo.instance()
	var projectile_rotation = mouse_rotation
	projectile.set_rotation(projectile_rotation)
	projectile.set_global_position(current_weapon.get_global_position())
	player.add_child(projectile)
	var direction_vector = (get_global_mouse_position() - self.get_global_position()).normalized()
	projectile.direction = direction_vector
	projectile.set_speed(ammo_speed)
	if weapon_anim_finished:
		weapon_anim_finished = false
		ranged_cooldown.start()

func shoot_charged():
	weapon_animation_player.play("attack")
	if count == 80:
		ammo_speed = 1500
		shoot_weapon()
		count = 0
	elif count < 80:
		ammo_speed = 700
		shoot_weapon()
		count = 0

func melee_attack():
	if weapon_anim_finished:
		weapon_anim_finished = false
		weapon_animation_player.play("attack")
		melee_cooldown.start()

func use_ability():
	current_weapon.activate()

func _on_MeleeCooldown_timeout():
	melee_cooldown.stop()

func _on_RangedCooldown_timeout():
	ranged_cooldown.stop()
	
func _on_AbilityCooldown_timeout():
	ability_cooldown.stop()

func camera_limit(right_limit, left_limit):
	camera.limit_right = right_limit
	camera.limit_left = left_limit

func camera_limit_reset():
	camera_limit(100000, -100000)

func camera_zoom(x, y):
	camera.set_zoom(Vector2(x,y))

var movement_path : Array

func write_movement_path():
	if $MovementStates.current_state.name != "Idle":
		movement_path.append(player.position)
		if $MovementTimer.is_stopped():
			$MovementTimer.start()
	else:
		$MovementTimer.stop()

func _on_movement_timer_timeout():
	movement_path.append(player.position)
	print("add")
	$MovementTimer.start()







