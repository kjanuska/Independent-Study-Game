extends Area2D

var health = 60
onready var animation_player = get_parent().get_node("AnimationPlayer")

func take_damage(damage):
	if health > 0:
		health -= damage
	if health <= 0:
		get_parent().get_node("States").current_state.dead()
		return
	animation_player.play("hurt")
