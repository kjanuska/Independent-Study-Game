extends Node2D

var time = 3.0

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "activate":
		$AnimationPlayer.play("idle")
		PlayerVar.player.ability_anim_finished = true
		PlayerVar.player.ability_cooldown.start()

func _on_FreezeArea_body_entered(body):
	AbilityVar.slowdown = 0

func _on_FreezeArea_body_exited(body):
	$Timers/FreezeTime.start()

func _on_FreezeTime_timeout():
	AbilityVar.slowdown = 0.7
	$Timers/SlowdownTimer.start()

func _on_SlowdownTimer_timeout():
	AbilityVar.slowdown = 1
