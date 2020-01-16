extends "../Motion.gd"

var ammo = preload("res://Scenes/Weapons/Ranged/Bow/Arrow.tscn")

func enter():
	var projectile = ammo.instance()
	var projectile_rotation = owner.get_angle_to_player()
	projectile.set_rotation(projectile_rotation)
	projectile.set_global_position(owner.get_global_position())
	owner.call_deferred("add_child", projectile)
	var direction_vector = Vector2(PlayerVar.player.position.x - owner.position.x, PlayerVar.player.position.y - owner.position.y).normalized()
	projectile.direction = direction_vector
	projectile.set_speed(500)

func _on_AttackRange_body_exited(body):
	emit_signal("finished", "chase")
