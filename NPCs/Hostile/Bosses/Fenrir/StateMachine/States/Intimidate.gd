extends "../Motion.gd"

func enter():
	PlayerVar.scent_visible = true

func update(_delta):
	pass

func exit():
	PlayerVar.scent_visible = false