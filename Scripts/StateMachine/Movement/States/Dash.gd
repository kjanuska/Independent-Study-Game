extends "../Motion.gd"

onready var dash_cooldown = owner.get_node("DashCooldown")

func enter():
	speed = 1500.0
	move_direction = get_input_direction()
	player_animation.travel("dash")
	owner.get_node("DashTimer").start()

func update(_delta):
	.move(speed, move_direction)

func _on_DashTimer_timeout():
	speed = 0.0
	emit_signal("finished", "previous")
	dash_cooldown.start()

func _on_DashCooldown_timeout():
	dash_cooldown.stop()
