extends "../Motion.gd"

func enter():
	animation_player.play("kick_dirt")

func update(_delta):
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "kick_dirt":
		emit_signal("finished", "chase")
