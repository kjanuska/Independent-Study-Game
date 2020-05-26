extends "../Motion.gd"

var opposite_direction

var t = 0
var run_away_distance = 40
var slowdown_distance = run_away_distance * 2/3

export (int) var SPEED = 300

func enter():
	opposite_direction = .get_direction(PlayerVar.player) * -1

func update(_delta):
	run_away_distance -= 1
	if run_away_distance > 0:
		if run_away_distance > slowdown_distance:
			t += _delta * 4.2
		else:
			t -= _delta * 2.5
		if t <= 0:
			t = 0
		else:
			.move(lerp(0, SPEED, t), opposite_direction)
	else:
		emit_signal("finished", "recover")