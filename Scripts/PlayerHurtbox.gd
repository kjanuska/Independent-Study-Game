extends Area2D

var health = 3
var is_invincible = false

func take_damage():
	if !is_invincible:
		print("yikes")
		health -= 1
		if health == 0:
			print("you died")
			return
		is_invincible = true
		$InvincibilityPeriod.start()

func _on_InvincibilityPeriod_timeout():
	is_invincible = false
	print("done")
