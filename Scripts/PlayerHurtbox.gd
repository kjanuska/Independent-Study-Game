extends Area2D

var health = 3
var is_vulnerable = true

func take_damage():
	if is_vulnerable:
		print(health)
		health -= 1
		if health == 0:
			print("you died")
			get_parent().player_animation.travel("death")
		is_vulnerable = false
		get_parent().player_animation.travel("hurt")
		$InvincibilityPeriod.start()

func _on_InvincibilityPeriod_timeout():
	is_vulnerable = true
	print("done")
