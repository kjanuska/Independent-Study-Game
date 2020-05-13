extends KinematicBody2D

var target

func _ready():
	$ChargePathNode.visible = false

func get_angle_to_player():
	return get_angle_to(PlayerVar.player.get_global_position()) + self.get_rotation()

func _physics_process(delta):
	target = PlayerVar.player