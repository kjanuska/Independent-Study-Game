extends "../Motion.gd"

var count = 20
var radius = 150
var circle

var angle_step = 2.0 * PI / count

var angle = 0

export(int) var SPEED = 200

var circle_path = []

onready var path = preload("res://NPCs/Hostile/Bosses/Fenrir/CirclePath.tscn")

func enter():
	circle = Game.level.get_node("circle")
	circle.position = fenrir.position
	for i in range(0, count):
		var direction = Vector2(cos(angle), sin(angle))
		var pos = circle.position + direction * radius
		
		var node = path.instance()
		node.set_position(pos)
		circle.add_child(node)
		circle_path.push_front(node)
		angle += angle_step

func update(_delta):
	direction = (circle_path[0].position - fenrir.position).normalized()
	.move(SPEED, direction)
	if fenrir.position == circle_path[0].position:
		circle_path.pop_front()
	






