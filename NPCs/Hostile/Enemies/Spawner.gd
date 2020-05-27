extends Node2D

onready var ghost_load = preload("res://NPCs/Hostile/Enemies/Ghost/Ghost.tscn")
onready var skeleton_load = preload("res://NPCs/Hostile/Enemies/Skeletons/SkeletonBase/Skeleton.tscn")
onready var slime_load = preload("res://NPCs/Hostile/Enemies/Slimes/SlimeBlue/SlimeBlue.tscn")
onready var viking_bow_load = preload("res://NPCs/Hostile/Enemies/VikingBow/VikingBow.tscn")
onready var viking_mage_load = preload("res://NPCs/Hostile/Enemies/VikingMage/VikingMage.tscn")
onready var viking_sword_load = preload("res://NPCs/Hostile/Enemies/VikingSword/VikingSword.tscn")

export(String) var type

func _ready():
	SignalManager.connect("scene_loaded", self, "spawn")

func spawn():
	match type:
		"ghost":
			var ghost = ghost_load.instance()
			initialize(ghost)
		"skeleton":
			var skeleton = skeleton_load.instance()
			initialize(skeleton)
		"slime":
			var slime = slime_load.instance()
			initialize(slime)
		"viking_bow":
			var viking_bow = viking_bow_load.instance()
			initialize(viking_bow)
			print(viking_bow.position)
		"viking_mage":
			var viking_mage = viking_mage_load.instance()
			initialize(viking_mage)
		"viking_sword":
			var viking_sword = viking_sword_load.instance()
			initialize(viking_sword)

func initialize(enemy):
	enemy.set_global_position(get_global_position())
	Game.world.add_child(enemy)