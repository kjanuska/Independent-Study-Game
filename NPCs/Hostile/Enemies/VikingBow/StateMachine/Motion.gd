extends "States.gd"

onready var idle_time = owner.get_node("Timers/IdleTime")
onready var patrol_time = owner.get_node("Timers/PatrolTime")
onready var enemy = self.get_parent().get_parent()
onready var animation_player = enemy.get_node("AnimationTree").get("parameters/playback")

var distance
var direction

var player_near = false

func get_random_direction():
	var move_direction = Vector2()
	move_direction = Vector2(randi() % 3 - 1, randi() % 3 - 1)
	while move_direction.length() == 0:
		move_direction = Vector2(randi() % 3 - 1, randi() % 3 - 1)
	return move_direction

func move(speed_value, direction):
	var motion = direction.normalized() * speed_value * enemy.slowdown
	owner.move_and_slide(motion)

func chase_target():
	var look = enemy.get_node("RayCast2D")
	look.cast_to = (enemy.target.position - enemy.position)
	look.force_raycast_update()

	if !look.is_colliding():
			direction = look.cast_to.normalized()
			distance = enemy.get_global_position().distance_to(PlayerVar.player.get_global_position())

	else:
		for scent in enemy.target.scent_trail:
			look.cast_to = (scent.position - enemy.position)
			look.force_raycast_update()

			if !look.is_colliding():
				direction = look.cast_to.normalized()
				distance = enemy.get_global_position().distance_to(PlayerVar.player.get_global_position())
				break

func play(animation):
	animation_player.travel(animation)

func _physics_process(_delta):
	if player_near:
		var aim = enemy.get_node("RayCast2D")
		aim.cast_to = (enemy.target.position - enemy.position)
		aim.force_raycast_update()
	
		if !aim.is_colliding():
			emit_signal("finished", "chase")
			set_physics_process(false)
		else:
			return
	else:
		return
