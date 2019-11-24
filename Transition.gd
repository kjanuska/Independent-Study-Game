extends Area2D

export(String, FILE, "*.tscn") var world_scene

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		SceneChanger.change_scene(world_scene)
