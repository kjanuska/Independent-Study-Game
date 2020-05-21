extends Area2D

var health = 300

func take_damage():
	health -= PlayerVar.damage
	SignalManager.emit_signal("take_damage")
