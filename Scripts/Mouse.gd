extends Sprite

var mouse_sprite

func _ready():
	mouse_sprite = $"."
	
func _physics_process(delta):
	mouse_sprite.position = get_viewport().get_mouse_position()
