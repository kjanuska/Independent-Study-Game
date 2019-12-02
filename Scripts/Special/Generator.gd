extends Node2D

var start_rooms = []
var regular_rooms = []
var end_rooms = []

export(String, DIR) var path
var temp_path

export(int) var level_number
export(int) var number_of_rooms
export(int) var hori_spread
export(int) var vert_spread
export(int) var empty_zone

func _ready():
#	randomize seed
	randomize()
	_get_files_in_directory()

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		_place_rooms()

func _get_files_in_directory():
	temp_path = str(path, "/Start")
	_create_list(temp_path, start_rooms)
	temp_path = str(path, "/Regular")
	_create_list(temp_path, regular_rooms)
	temp_path = str(path, "/End")
	_create_list(temp_path, end_rooms)

func _create_list(path_to_folder, save_var):
	var dir = Directory.new()
	dir.open(path_to_folder)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			save_var.append(str(path_to_folder, "/", file))
	dir.list_dir_end()

func _place_rooms():
#	chose 1 random start and end room since there can only be one of each type in the level
	var start_room = start_rooms[randi() % start_rooms.size()]
	var end_room = end_rooms[randi() % end_rooms.size()]
#	get 5 random rooms from regular rooms
	var rooms = _get_random_rooms()
	var old_pos = []
	print(rooms)
	for r in rooms.size():
		rooms[r] = load(rooms[r])
		rooms[r] = rooms[r].instance()
		get_parent().add_child(rooms[r])
		rooms[r].position = Vector2(randi() % hori_spread, randi() % vert_spread)
		var size = rooms[r].get_map_size()
		var pos = rooms[r].get_map_position()
		for o in old_pos.size():
			if (Rect2(pos[0], pos[1]).intersects(Rect2(old_pos[o][0], old_pos[o][1]))):
				rooms[r].position = Vector2(randi() % hori_spread + empty_zone, randi() % vert_spread + empty_zone)
				pos = rooms[r].get_map_position()
				print("intersect")
		old_pos.append([pos[0], pos[1]])

func _get_random_rooms():
	if number_of_rooms > regular_rooms.size():
		print("More rooms chosen than rooms available!")
		return
	var random = []
	for r in regular_rooms.size():
		random.append(r + 1)
	random.shuffle()
	var result = []
	for i in number_of_rooms:
		result.append(str("res://Scenes/Levels/Level", level_number, "/Regular/Room", random[i], ".tscn"))
	return result
