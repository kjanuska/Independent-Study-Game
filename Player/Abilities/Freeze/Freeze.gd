extends Node2D

var time = 3.0

onready var ice_cube_load = preload("res://Player/Abilities/Freeze/IceCubeAnimation.tscn")

func _ready():
	$AnimationPlayer.play("idle")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "activate":
		$AnimationPlayer.play("idle")
		PlayerVar.player.ability_anim_finished = true
		PlayerVar.player.ability_cooldown.start()

func _on_FreezeArea_body_entered(body):
	var ice_cube = ice_cube_load.instance()
	body.add_child(ice_cube)
	ice_cube.target_body = body
	ice_cube.target_body.slowdown = 0

