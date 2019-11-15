extends "InputParse.gd"

func set_weapon_rotation():
	current_weapon.set_rotation(mouse_rotation)

func get_input():
	if Input.is_action_pressed("shoot"):
		if ranged != null:
			if current_weapon == melee:
				equip(equipped_ranged_id)
			count += 1
			if ranged == bow_load:
				if count >= 80:
					$Charged.popup()
			else:
				shoot_weapon(equipped_ammo, ammo_speed)
				count = 0
		
	if Input.is_action_just_released("shoot") && charge_ranged:
		shoot_charged()
		
	if Input.is_action_just_pressed("melee"):
		if equipped_melee != null:
			if current_weapon == ranged:
				current_weapon = melee
				equip(equipped_melee_id)
			if melee_attack_cooldown.is_stopped():
				melee_attack()
