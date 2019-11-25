extends Node2D

var levels

var files

export(String, DIR) var path

func _ready():
	_get_files_in_directory()
	_separate_files()

func _get_files_in_directory():
	files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)
	dir.list_dir_end()

func _separate_files():
	for i in files.size():
		pass