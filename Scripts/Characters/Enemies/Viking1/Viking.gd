extends KinematicBody2D

onready var nav_2d = get_tree().get_current_scene().get_node("Navigation2d")
onready var enemy = get_tree().get_current_scene().get_node("World").get_node("Viking1")

var path = PoolVector2Array() setget set_path

func _physics_process(delta):
	if enemy.chasing:
		var new_path = nav_2d.get_simple_path(enemy.global_position, PlayerVar.player.global_position)
		enemy.path = new_path

func get_angle_to_player():
	return get_angle_to(PlayerVar.player.get_global_position()) + self.get_rotation()

func _on_FindArea_body_entered(body):
	if body.get_name() == "Player":
		SignalManager.emit_signal("player_found")

func set_path(value: PoolVector2Array):
	path = value
	if value.size() == 0:
		return
	enemy.chasing = true
