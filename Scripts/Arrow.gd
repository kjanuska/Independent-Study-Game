extends Area2D

var speed = 1000

var direction = Vector2()

func _ready():
	set_as_toplevel(true)
	$".".set_z_index(-2)

func _physics_process(delta):
	position.x += direction.x * speed * delta
	position.y += direction.y * speed * delta

func set_speed(speed_value):
	speed = speed_value

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
