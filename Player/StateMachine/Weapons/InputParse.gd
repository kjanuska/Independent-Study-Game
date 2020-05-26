extends "../States.gd"

var current_weapon
var melee
var ranged
var ability
var ammo
var ammo_speed

var mouse_rotation

onready var weapon_spawner = owner.get_node("Spawners").get_node("WeaponSpawner")
onready var projectile_spawner = owner.get_node("Spawners").get_node("ProjectileSpawner")
onready var ability_spawner = owner.get_node("Spawners").get_node("AbilitySpawner")

func check_for_ability():
	if owner.ability_cooldown.is_stopped() && owner.ability_anim_finished && owner.current_ability != null:
		if Input.is_action_just_pressed("use_ability"):
			emit_signal("finished", "ability")

func get_input_rotation():
	mouse_rotation = owner.get_input_rotation()
	return mouse_rotation

