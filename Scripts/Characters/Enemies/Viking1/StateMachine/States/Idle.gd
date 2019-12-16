extends "../Motion.gd"

func enter():
	print("idle")
	idle_time.start()

func _on_IdleTime_timeout():
	idle_time.stop()
	emit_signal("finished", "patrol")
