extends Area2D

var health = 300

func take_damage(damage):
	health -= damage
	SignalManager.emit_signal("take_damage")
