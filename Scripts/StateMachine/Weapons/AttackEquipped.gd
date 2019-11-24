extends "InputParse.gd"

var count = 0

func set_weapon_rotation():
	owner.current_weapon.set_rotation(get_input_rotation())

func get_ranged_input():
	if owner.ranged_cooldown.is_stopped():
		if Input.is_action_pressed("shoot"):
			count += 1
			if PlayerVar.charge_ranged:
				if count == 80:
					owner.weapon_animation_player.play("charge")
					owner.count = count
			else:
				owner.shoot_weapon()
				count = 0
	
		if Input.is_action_just_released("shoot") && PlayerVar.charge_ranged:
			owner.shoot_charged()
			count = owner.count

func get_melee_input():
	if owner.melee_cooldown.is_stopped():
		if Input.is_action_just_pressed("melee"):
			owner.melee_attack()
