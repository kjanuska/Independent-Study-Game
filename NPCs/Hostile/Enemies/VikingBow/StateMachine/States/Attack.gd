extends "../Motion.gd"

var ammo = preload("res://NPCs/Hostile/Enemies/VikingBow/EnemyArrow.tscn")
var can_shoot = true

var aim_rotation

func enter():
	aim()
	shoot()

func update(_delta):
	aim()
	if distance > 100:
		emit_signal("finished", "chase")
	shoot()

func aim():
	var aim = enemy.get_node("AimSights")
	aim.cast_to = (enemy.target.position - enemy.position)
	aim.force_raycast_update()

	if !aim.is_colliding():
			aim_rotation = aim.cast_to.normalized()
			distance = enemy.get_global_position().distance_to(PlayerVar.player.get_global_position())

	else:
		can_shoot = false
		emit_signal("finished", "chase")

func shoot():
	if can_shoot:
		.play("attack")
		enemy.get_node("Timers").get_node("Draw").start()

func _on_ShotCooldown_timeout():
	can_shoot = true

func dead():
	emit_signal("finished", "dead")

func _on_Draw_timeout():
	print('done')
	enemy.get_node("Timers").get_node("Draw").stop()
	var projectile = ammo.instance()
	projectile.set_rotation(aim_rotation.angle())
	projectile.set_global_position(owner.get_global_position())
	owner.call_deferred("add_child", projectile)
	var direction_vector = aim_rotation
	projectile.direction = direction_vector
	projectile.set_speed(800)
	can_shoot = false
	owner.get_node("Timers").get_node("ShotCooldown").start()
