extends Area2D

var SPEED = 3000
var DAMAGE = 20

var direction = Vector2()

func _ready():
	set_as_toplevel(true)
	$".".set_z_index(-2)
	
func _physics_process(delta):
	position.x += direction.x * SPEED * delta
	position.y += direction.y * SPEED * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
