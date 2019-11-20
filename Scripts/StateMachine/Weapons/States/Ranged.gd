extends "../AttackEquipped.gd"

func enter():
	owner.equip()
	owner.weapon_animation_player.play("idle")

func update(_delta):
	.set_weapon_rotation()
	.get_ranged_input()
	if Input.is_action_just_pressed("melee") && owner.previous_weapon_id != null:
		owner.id = owner.previous_weapon_id
		emit_signal("finished", "transition")

