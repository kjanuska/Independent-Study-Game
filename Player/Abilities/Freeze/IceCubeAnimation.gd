extends Sprite

var target_body

func _ready():
	$AnimationPlayer.play("freeze")
	get_node("FreezeTime").start()

func _on_FreezeTime_timeout():
	target_body.slowdown = 0.5
	get_node("SlowdownTime").start()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "freeze":
		$FreezeTime.start()

func _on_SlowdownTime_timeout():
	target_body.slowdown = 1
	queue_free()
