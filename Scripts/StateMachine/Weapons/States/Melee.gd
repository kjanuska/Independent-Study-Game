extends "../AttackEquipped.gd"

func enter():
	print("melee")
	owner.equip()

func update(_delta):
	.set_weapon_rotation()
	.get_melee_input()
	if Input.is_action_just_pressed("shoot") && previous_weapon:
		owner.id = previous_weapon.id
		emit_signal("finished", "transition")
