extends "../Motion.gd"

onready var dash_cooldown = owner.get_node("DashCooldown")

func enter():
	if dash_cooldown.is_stopped():
		speed *= 5
		var move_direction = get_input_direction()
		
		owner.get_node("AnimationPlayer").play("dash")
		.move(speed, move_direction)
		owner.get_node("DashTimer").start()

func _on_DashTimer_timeout():
	speed /= 5
	dash_cooldown.start()

func _on_DashCooldown_timeout():
	dash_cooldown.stop()
