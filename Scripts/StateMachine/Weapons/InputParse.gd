extends "../States.gd"

var current_weapon
var melee
var ranged
var charge_ranged
var ammo
var ammo_speed

var previous_weapon_id

var mouse_rotation

onready var weapon_spawner = owner.get_node("Spawners").get_node("WeaponSpawner")
onready var projectile_spawner = owner.get_node("Spawners").get_node("ProjectileSpawner")

func get_input_rotation():
	mouse_rotation = owner.get_input_rotation()
	return mouse_rotation

