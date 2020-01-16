extends "../AttackEquipped.gd"

var remove_weapon
var disabled_ability_button = null
onready var radial_menu = owner.get_node("RadialMenu")

func enter():
	activate()

func update(_delta):
	if owner.ability_anim_finished != true:
		.set_weapon_rotation(owner.current_ability)
	else:
		if PlayerVar.current_weapon_id != null:
			emit_signal("finished", "transition")
		else:
			emit_signal("finished", "empty")

func handle_input(event):
	return .handle_input(event)

func activate():
	if remove_weapon && owner.current_weapon:
		owner.current_weapon.queue_free()
		owner.current_weapon = null
	owner.ability_animation_player.play("activate")
	owner.ability_anim_finished = false

func enable_and_disable_buttons(selected_ability_name):
	if disabled_ability_button != null:
		radial_menu.get_node(disabled_ability_button).disabled = false
		owner.current_ability.queue_free()
	radial_menu.get_node(selected_ability_name).disabled = true
	disabled_ability_button = selected_ability_name

func _on_Shield_pressed():
	enable_and_disable_buttons("Shield")
	remove_weapon = true
	owner.current_ability = ability_spawner.shield_load
	owner.equip_ability()
	owner.get_node("AbilityCooldown").wait_time = owner.timer

func _on_Freeze_pressed():
	enable_and_disable_buttons("Freeze")
	owner.current_ability = ability_spawner.freeze_load
	owner.equip_ability()
	owner.get_node("AbilityCooldown").wait_time = owner.timer
