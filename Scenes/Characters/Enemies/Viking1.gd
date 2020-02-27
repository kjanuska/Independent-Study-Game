extends Navigation2D

export(float) var character_speed = 400.0
var path = []

func _ready():
	$Viking1/Timers/CheckLocation.start()
	
func _physics_process(delta):
	if PlayerVar.chasing:
		var walk_distance = character_speed * delta
		move_along_path(walk_distance)

func move_along_path(distance):
	var last_point = $Viking1.position
	while path.size():
		var distance_between_points = last_point.distance_to(path[0])
		# The position to move to falls between two points.
		if distance <= distance_between_points:
			$Viking1.position = last_point.linear_interpolate(path[0], distance / distance_between_points)
			return
		# The position is past the end of the segment.
		distance -= distance_between_points
		last_point = path[0]
		path.remove(0)
	# The character reached the end of the path.
	$Viking1.position = last_point

func _update_navigation_path(start_position, end_position):
	# get_simple_path is part of the Navigation2D class.
	# It returns a PoolVector2Array of points that lead you
	# from the start_position to the end_position.
	path = get_simple_path(start_position, end_position, true)
	# The first point is always the start_position.
	# We don't need it in this example as it corresponds to the character's position.
	path.remove(0)


func _on_CheckLocation_timeout():
	if $Viking1/VisibilityNotifier2D.is_on_screen():
		_update_navigation_path($Viking1.position, PlayerVar.player.position)
		print("found")
		$Viking1/Timers/CheckLocation.start()
