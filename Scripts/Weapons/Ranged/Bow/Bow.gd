extends Node2D

var id = 10
var time = 1

func _on_AnimationPlayer_animation_finished(anim_name):
	PlayerVar.player.anim_finished = true
