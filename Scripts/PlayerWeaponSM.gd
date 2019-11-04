extends StateMachine

func _ready():
	add_state("weapon_idle")
	add_state("attack_ranged")
	add_state("equipped_ranged")
	add_state("attack_melee")
	add_state("equipped_melee")
	add_state("pick_up")
	call_deferred("set_state", states.weapon_idle)

func _state_logic(delta):
	if player.current_weapon != null:
		player.apply_weapon_rotation()

func _get_transtion(delta):
	match state:
		states.equipped_ranged:
			pass

	return null

func _enter_state(new_state, old_state):
	match new_state:
		states.attack_ranged:
			pass
#			animation for shooting ranged
		states.attack_melee:
			pass
#			animation for melee attack

func _exit_state(old_state, new_state):
	pass	