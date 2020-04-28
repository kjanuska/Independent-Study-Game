extends "../Motion.gd"

export(int) var SPEED = 200
var direction

func enter():
	chase_target()

func chase_target():
	var look = enemy.get_node("RayCast2D")
	look.cast_to = (enemy.target.position - enemy.position)
	look.force_raycast_update()
	
	if !look.is_colliding():
			direction = look.cast_to.normalized()
	
	else:
		for scent in enemy.target.scent_trail:
			look.cast_to = (scent.position - enemy.position)
			look.force_raycast_update()

			if !look.is_colliding():
				direction = look.cast_to.normalized()
				break

func update(_delta):
	chase_target()
	if direction != null:
		.move(SPEED, direction)

func _on_AttackRange_body_entered(body):
	if body.get_name() == "Player":
		emit_signal("finished", "attack")
