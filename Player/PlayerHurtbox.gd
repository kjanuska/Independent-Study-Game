extends Area2D

var health = 100
var is_vulnerable = true

func take_damage(damage):
	if is_vulnerable:
		print(health)
		health -= damage
		if health <= 0:
			print("you died")
			get_parent().player_animation.travel("death")
			owner.get_node("MovementStates").set_physics_process(false)
			owner.get_node("WeaponStates").set_physics_process(false)
			is_vulnerable = false
			return
		is_vulnerable = false
		get_parent().player_animation.travel("hurt")
		$InvincibilityPeriod.start()

func _on_InvincibilityPeriod_timeout():
	is_vulnerable = true
