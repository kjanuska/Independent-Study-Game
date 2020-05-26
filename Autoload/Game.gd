extends Node

onready var level = get_tree().get_current_scene()
onready var world = level.get_node("World")
onready var effects = level.get_node("effects")

func _ready():
	SignalManager.connect("scene_loaded", self, "update")

func update():
	print("update")
	level = get_tree().get_current_scene()
	world = level.get_node("World")
	effects = level.get_node("effects")
	