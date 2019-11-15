extends "../InputParse.gd"

signal weapon_changed(id)

func ready():
	self.connect("weapon_changed", self, "_assign_id")

func enter():
	print("transition")

# specific weapon ids for each type
# melee in 1s
# 0 = sword
# 
# ranged in 10s
# 10 = bow
# 11 = gun
func _assign_id(id):
	if id < 10:
		match id:
			0:
				melee = weapon_spawner.sword_load
	elif id >= 10:
		match id:
			10:
				ranged = weapon_spawner.bow_load
				ammo = projectile_spawner.arrow_load
			11:
				ranged = weapon_spawner.gun_load
				ammo = projectile_spawner.bullet_load
				ammo_speed = 3000