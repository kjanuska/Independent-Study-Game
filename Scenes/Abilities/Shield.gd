extends Node2D

var time = 2.0

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "activate":
		$AnimationPlayer.play("idle")
		PlayerVar.player.ability_anim_finished = true
		PlayerVar.player.ability_cooldown.start()

