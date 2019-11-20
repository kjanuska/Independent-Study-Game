extends "InputParse.gd"

var count = 0

func set_weapon_rotation():
	owner.current_weapon.set_rotation(get_input_rotation())

func get_ranged_input():
	if Input.is_action_pressed("shoot"):
		count += 1
		if owner.charge_ranged:
			if count == 80:
				owner.weapon_animation_player.play("charge")
				owner.count = count
		else:
			owner.shoot_weapon()
			count = 0

	if Input.is_action_just_released("shoot") && owner.charge_ranged:
		owner.shoot_charged()
		count = owner.count

func get_melee_input():
	if Input.is_action_just_pressed("melee"):
		if owner.attack_cooldown.is_stopped():
			owner.melee_attack()
