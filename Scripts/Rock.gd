extends Area2D

var health = 2

onready var animation_player = get_parent().get_node("AnimationPlayer")

func take_damage():
	if health > 1:
		animation_player.play("hurt")
		health -= 1
	else:
		animation_player.play("death")
		

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "death":
		get_parent().queue_free()
