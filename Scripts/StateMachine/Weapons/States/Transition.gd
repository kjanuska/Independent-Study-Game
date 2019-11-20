extends "../InputParse.gd"

func enter():
	if owner.current_weapon:
		owner.previous_weapon_id = owner.current_weapon.id
		owner.current_weapon.queue_free()
	_assign_id(owner.id)

func update(_delta):
	.get_input_rotation()

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
		owner.current_weapon = melee
		emit_signal("finished", "melee")
	elif id >= 10:
		match id:
			10:
				ranged = weapon_spawner.bow_load
				owner.ammo = projectile_spawner.arrow_load
				owner.ammo_speed = 1000
				owner.charge_ranged = true
			11:
				ranged = weapon_spawner.gun_load
				owner.ammo = projectile_spawner.bullet_load
				owner.ammo_speed = 3000
				owner.charge_ranged = false
		owner.current_weapon = ranged
		emit_signal("finished", "ranged")