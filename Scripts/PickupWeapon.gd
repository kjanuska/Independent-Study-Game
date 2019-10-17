extends Area2D

export var weapon = 11

var player

func _ready():
	player = get_tree().get_root().get_node("Main").get_node("Player")

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		player.equip(weapon)
