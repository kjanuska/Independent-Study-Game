extends Area2D

var health = 100
onready var animation_player = get_parent().get_node("AnimationPlayer")

func take_damage(damage):
	health -= damage
	print(health)
	if health <= 0:
		SignalManager.emit_signal("dead")
		return
	animation_player.play("hurt")
