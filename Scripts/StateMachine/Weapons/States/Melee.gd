extends "../AttackEquipped.gd"

func enter():
	owner.equip()

func update(_delta):
	.set_weapon_rotation()
	.get_melee_input()
	if Input.is_action_just_pressed("shoot") && owner.previous_weapon:
		owner.id = owner.previous_weapon.id
		emit_signal("finished", "transition")
