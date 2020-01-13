extends Node2D

var id = 20
var time = 2.0

func activate():
	print("shield")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		PlayerVar.player.anim_finished = true
