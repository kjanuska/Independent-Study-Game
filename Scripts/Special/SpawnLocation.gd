extends Node2D

export(NodePath) var player

func _ready():
#	= get_tree().get_node("Main").get_node("World").get_node("Player")
	player = get_node(player)
	player.position = self.position
