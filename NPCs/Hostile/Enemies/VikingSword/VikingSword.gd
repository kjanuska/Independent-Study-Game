extends KinematicBody2D

var target

var slowdown = 1

func get_angle_to_player():
	return get_angle_to(PlayerVar.player.get_global_position()) + self.get_rotation()

func _physics_process(delta):
	target = PlayerVar.player

func _on_Sword_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_damage(15)
