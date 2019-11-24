extends CanvasLayer

func change_scene(path):
	$AnimationPlayer.play("fade")
	yield($AnimationPlayer, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	$AnimationPlayer.play_backwards("fade")
	yield($AnimationPlayer, "animation_finished")
	SignalManager.emit_signal("scene_changed")
