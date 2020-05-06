extends Node

onready var level = get_tree().get_current_scene()
onready var world = level.get_node("World")
onready var effects = level.get_node("effects")