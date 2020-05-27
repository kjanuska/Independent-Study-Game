extends "../Motion.gd"

func _ready():
	SignalManager.connect("player_found", self , "player_found")

func enter():
	.play("idle")
	idle_time.start()

func _on_IdleTime_timeout():
	idle_time.stop()
	if get_parent().current_state.name == "Idle":
		emit_signal("finished", "patrol")

func player_found():
	emit_signal("finished", "chase")

func dead():
	emit_signal("finished", "dead")