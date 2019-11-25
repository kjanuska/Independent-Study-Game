extends CanvasLayer

func change_scene(path):	
	$AnimationPlayer.play("fade")
	yield($AnimationPlayer, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	yield(get_tree().create_timer(0.1), "timeout")
	SignalManager.emit_signal("weapon_changed")
	$AnimationPlayer.play_backwards("fade")
	yield($AnimationPlayer, "animation_finished")
	SignalManager.emit_signal("scene_changed")