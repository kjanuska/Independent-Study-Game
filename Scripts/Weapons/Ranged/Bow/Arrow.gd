extends Area2D

var speed

var direction = Vector2()

func _ready():
	set_as_toplevel(true)

func _physics_process(delta):
	position.x += direction.x * speed * delta
	position.y += direction.y * speed * delta

func set_speed(speed_value):
	speed = speed_value

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Arrow_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_damage()
		speed = 0
