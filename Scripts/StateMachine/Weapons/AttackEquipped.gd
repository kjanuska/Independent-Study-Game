extends "InputParse.gd"

var count = 0

func set_weapon_rotation():
	owner.current_weapon.set_rotation(get_input_rotation())

func get_ranged_input():
	if Input.is_action_pressed("shoot"):
		count += 1
		if ranged == weapon_spawner.bow_load:
			if count >= 80:
				$Charged.popup()
		else:
			owner.shoot_weapon(ammo, ammo_speed)
			count = 0

	if Input.is_action_just_released("shoot") && charge_ranged:
		owner.shoot_charged()

func get_melee_input():
	if Input.is_action_just_pressed("melee"):
		if owner.attack_cooldown.is_stopped():
			owner.melee_attack()
