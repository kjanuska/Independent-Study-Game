extends "../AttackEquipped.gd"

func enter():
	activate()

func update(_delta):
	if owner.ability_anim_finished != true:
		.set_weapon_rotation(owner.current_ability)

func handle_input(event):
	return .handle_input(event)

func activate():
	owner.ability_animation_player.play("activate")
	owner.ability_anim_finished = false

func _on_Shield_pressed():
	owner.current_ability = ability_spawner.shield_load
	owner.equip_ability()
	owner.get_node("AbilityCooldown").wait_time = owner.timer

func _on_Freeze_pressed():
	owner.current_ability = ability_spawner.freeze_load
	owner.equip_ability()
	owner.get_node("AbilityCooldown").wait_time = owner.timer
