extends "../AttackEquipped.gd"

func enter():
	owner.equip()
	owner.get_node("WeaponTimers").get_node("AbilityCooldown").wait_time = owner.timer

func update(_delta):
	.set_weapon_rotation()

func handle_input(event):
	return .handle_input(event)
