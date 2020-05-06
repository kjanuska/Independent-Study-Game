extends Node2D

export(NodePath) var player

func _ready():
	player = get_node(player)
	player.position = position
