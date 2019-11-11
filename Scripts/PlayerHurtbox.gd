extends Area2D

var health = 3
var is_vulnerable = true

func take_damage():
	if is_vulnerable:
		print("yikes")
		health -= 1
		if health == 0:
			print("you died")
			return
		is_vulnerable = false
		get_parent().get_node("AnimationPlayer").play("invulnerable")
		$InvincibilityPeriod.start()

func _on_InvincibilityPeriod_timeout():
	is_vulnerable = true
	print("done")
