extends "../Motion.gd"

var ammo = preload("res://Scenes/Weapons/Ranged/Bow/Arrow.tscn")
var can_shoot = true

func enter():
	pass

func update(_delta):
	if AbilityVar.slowdown != 0:
		shoot()

func shoot():
	if can_shoot:
		var projectile = ammo.instance()
		var projectile_rotation = owner.get_angle_to_player()
		projectile.set_rotation(projectile_rotation)
		projectile.set_global_position(owner.get_global_position())
		owner.call_deferred("add_child", projectile)
		var direction_vector = Vector2(PlayerVar.player.position.x - owner.position.x, PlayerVar.player.position.y - owner.position.y).normalized()
		projectile.direction = direction_vector
		projectile.set_speed(500)
		can_shoot = false
		owner.get_node("Timers").get_node("ShotCooldown").start()

func _on_AttackRange_body_exited(body):
	emit_signal("finished", "chase")

func _on_ShotCooldown_timeout():
	can_shoot = true
