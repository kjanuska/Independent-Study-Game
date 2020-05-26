extends Area2D

var health = 2
var stuck_arrows = []

onready var animation_player = get_parent().get_node("AnimationPlayer")

func take_damage():
	if health > 1:
		animation_player.play("hurt")
		health -= 1
	else:
		animation_player.play("death")
		

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "death":
#		for i in stuck_arrows.size():
#			stuck_arrows[i].queue_free()
		queue_free()

func _on_Area2D_area_entered(area):
	if area.is_in_group("arrow"):
		stuck_arrows.append(area)
