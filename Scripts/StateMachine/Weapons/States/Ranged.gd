extends "../AttackEquipped.gd"

func enter():
	owner.equip()
	owner.get_node("WeaponTimers").get_node("RangedCooldown").wait_time = owner.timer
	owner.weapon_animation_player.play("idle")

func update(_delta):
	.set_weapon_rotation(owner.current_weapon)
	.get_ranged_input()
	.check_for_melee()
	.check_for_ability()

