extends Node2D

var levels

var start_levels = []
var regular_levels = []
var end_levels = []

export(String, DIR) var path
var temp_path

func _ready():
	_get_files_in_directory()
	print(start_levels)
	print(regular_levels)
	print(end_levels)

func _get_files_in_directory():
	temp_path = str(path, "/Start")
	_create_list(temp_path, start_levels)
	temp_path = str(path, "/Regular")
	_create_list(temp_path, regular_levels)
	temp_path = str(path, "/End")
	_create_list(temp_path, end_levels)

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












