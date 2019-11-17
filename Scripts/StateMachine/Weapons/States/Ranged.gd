extends "../AttackEquipped.gd"

func enter():
	print("ranged")
	owner.equip()

func update(_delta):
	.set_weapon_rotation()
	.get_ranged_input()
	if Input.is_action_just_pressed("melee") && previous_weapon:
		emit_signal("finished", "transition")

