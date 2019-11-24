extends Node2D

onready var player = get_tree().get_root().get_node("Main").get_node("Player")

func _ready():
	player.position = self.position
