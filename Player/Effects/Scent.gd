extends Node2D

var player

func _ready():
	$Timer.connect("timeout", self, "remove_scent")

func remove_scent():
	player.scent_trail.erase(self)
	if $Trail.visible == true:
		$AnimationPlayer.play("dissolve")
	else:
		queue_free()

func enable_scent(value):
	$Trail.visible = value

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "dissolve":
		queue_free()
