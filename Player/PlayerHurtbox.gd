extends Area2D

var health = 100

func take_damage(damage):
	if PlayerVar.is_vulnerable:
		print(health)
		health -= damage
		if health <= 0:
			print("you died")
			get_parent().player_animation.travel("death")
			owner.get_node("MovementStates").set_physics_process(false)
			owner.get_node("WeaponStates").set_physics_process(false)
			PlayerVar.is_vulnerable = false
			return
		PlayerVar.is_vulnerable = false
		get_parent().player_animation.travel("hurt")
		$InvincibilityPeriod.start()

func _on_InvincibilityPeriod_timeout():
	PlayerVar.is_vulnerable = true
