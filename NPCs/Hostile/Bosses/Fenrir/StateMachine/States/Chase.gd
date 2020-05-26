extends "../Motion.gd"

export(int) var SPEED = 200

func _ready():
	SignalManager.connect("take_damage", self , "damage")
	fenrir.get_node("DefenseRange").get_node("CollisionShape2D").disabled = true

func enter():
	.chase_target()

func check_aim():
	if distance == null:
		return
	elif distance <= 50:
		emit_signal("finished", "attack")

func update(_delta):
	.chase_target()
	check_aim()
	if direction != null:
		.move(SPEED, direction)

func damage():
	emit_signal("finished", "stagger")