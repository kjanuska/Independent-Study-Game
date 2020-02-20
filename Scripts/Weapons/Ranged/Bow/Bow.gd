extends Node2D

var id = 10
var time = 1

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		PlayerVar.player.weapon_anim_finished = true
