extends "../InputParse.gd"

var wait_time

func enter():
	if owner.current_weapon:
		owner.current_weapon.queue_free()
	if PlayerVar.current_weapon_id != null:
		_assign_id(PlayerVar.current_weapon_id)

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
				wait_time = 0.5
				PlayerVar.damage = 40
		owner.current_weapon = melee
		owner.get_node("WeaponTimers").get_node("MeleeCooldown").wait_time = wait_time
		owner.timer = owner.get_node("WeaponTimers").get_node("MeleeCooldown")
		emit_signal("finished", "melee")
	elif id >= 10:
		match id:
			10:
				ranged = weapon_spawner.bow_load
				owner.ammo = projectile_spawner.arrow_load
				owner.ammo_speed = 700
				PlayerVar.charge_ranged = true
				PlayerVar.damage = 50
				wait_time = 1
			11:
				ranged = weapon_spawner.gun_load
				owner.ammo = projectile_spawner.bullet_load
				PlayerVar.charge_ranged = false
				wait_time = 0.2
		owner.current_weapon = ranged
		owner.get_node("WeaponTimers").get_node("RangedCooldown").wait_time = wait_time
		owner.timer = owner.get_node("WeaponTimers").get_node("RangedCooldown")
		emit_signal("finished", "ranged")









