extends "../AttackEquipped.gd"

func enter():
	owner.equip()
	owner.get_node("WeaponTimers").get_node("MeleeCooldown").wait_time = owner.timer

func update(_delta):
	.set_weapon_rotation()
	.get_melee_input()
	.check_for_ranged()
