extends Camera2D

func _physics_process(delta):
	self.position.x = (get_local_mouse_position().x + owner.get_position().x)
	self.position.y = (get_local_mouse_position().y + owner.get_position().y)/5