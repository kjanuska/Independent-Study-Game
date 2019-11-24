extends "../AttackEquipped.gd"

func enter():
	owner.equip()
	owner.get_node("WeaponTimers").get_node("MeleeCooldown").wait_time = owner.timer

func update(_delta):
	.set_weapon_rotation()
	.get_melee_input()
	if Input.is_action_just_pressed("shoot") && PlayerVar.previous_weapon_id != null && owner.anim_finished:
		PlayerVar.current_weapon_id = PlayerVar.previous_weapon_id
		emit_signal("finished", "transition")
