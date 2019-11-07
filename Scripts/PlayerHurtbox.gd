extends Area2D

var health = 3

func take_damage():
	health -= 1
	if health == 0:
		print("you died")
	$CollisionShape2D.disabled = true
	$InvincibilityPeriod.start()

func _on_InvincibilityPeriod_timeout():
	$CollisionShape2D.disabled = false
