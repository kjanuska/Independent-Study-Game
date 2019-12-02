extends Node2D

func get_map_size():
	return $TileMap.map_to_world($TileMap.get_used_rect().size)

func get_map_position():
	var center = $TileMap.get_global_position()
	var size = get_map_size()
	var topleft = Vector2(center.x - (size.x/2), center.y - (size.y/2))
	var bottomright = Vector2(center.x + (size.x/2), center.y + (size.y/2))
	var pos = [topleft, bottomright, center]
	return pos