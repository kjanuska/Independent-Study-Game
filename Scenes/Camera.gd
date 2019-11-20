extends Camera2D

func _physics_process(delta):
	self.position.x = (get_parent().position.x + get_local_mouse_position().x)/2
	self.position.y = (get_parent().position.y + get_local_mouse_position().y)/2