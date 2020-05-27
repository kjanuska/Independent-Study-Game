extends Area2D

var speed

var direction = Vector2()

func _ready():
	set_as_toplevel(true)
	$AnimationPlayer.play("fire")

func _physics_process(delta):
	position.x += direction.x * speed * delta * AbilityVar.slowdown
	position.y += direction.y * speed * delta * AbilityVar.slowdown

func set_speed(speed_value):
	speed = speed_value

func _on_VisibilityNotifier2D_screen_exited():
	if speed != 0:
		queue_free()

func _on_Fireball_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_damage(25)
		queue_free()

func _on_Fireball_body_entered(body):
	if body.get_class() == "TileMap" && body.get_name() == "Walls":
		queue_free()
