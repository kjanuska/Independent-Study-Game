extends Sprite

func _on_FreezeTime_timeout():
	$AnimationPlayer.play("break")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "freeze":
		$FreezeTime.start()
