extends Node2D

var time = 3.0

onready var ice_cube_load = preload("res://Abilities/IceCubeAnimation.tscn")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "activate":
		$AnimationPlayer.play("idle")
		PlayerVar.player.ability_anim_finished = true
		PlayerVar.player.ability_cooldown.start()

func _on_FreezeArea_body_entered(body):
	AbilityVar.slowdown = 0
	var ice_cube = ice_cube_load.instance()
	body.add_child(ice_cube)

func _on_FreezeArea_body_exited(body):
	$Timers/FreezeTime.start()

func _on_FreezeTime_timeout():
	AbilityVar.slowdown = 0.7
	$Timers/SlowdownTimer.start()

func _on_SlowdownTimer_timeout():
	AbilityVar.slowdown = 1
