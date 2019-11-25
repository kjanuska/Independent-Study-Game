extends "../AttackEquipped.gd"

func enter():
	owner.equip()
	owner.get_node("WeaponTimers").get_node("RangedCooldown").wait_time = owner.timer
	owner.weapon_animation_player.play("idle")

func update(_delta):
	.set_weapon_rotation()
	.get_ranged_input()
	if Input.is_action_just_pressed("melee") && PlayerVar.previous_weapon_id != null && owner.anim_finished:
		PlayerVar.temp_id = PlayerVar.current_weapon_id
		PlayerVar.current_weapon_id = PlayerVar.previous_weapon_id
		PlayerVar.previous_weapon_id = PlayerVar.temp_id
		emit_signal("finished", "transition")

