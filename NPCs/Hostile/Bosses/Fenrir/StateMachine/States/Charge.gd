extends "../Motion.gd"

onready var charge_path = fenrir.get_node("ChargePathNode")

export(int) var SPEED = 500
var charge_direction

var angle

var t = 0
var charge_distance = 70
var slowdown_distance = charge_distance / 2

var charged = false

func _ready():
	SignalManager.connect("take_damage", self , "damage")

func enter():
	charge_path.visible = true
	animation_player.play("charge_path_flash")
	fenrir.get_node("Timers").get_node("ChargeTimer").start()

func update(_delta):
	if not charged:
		angle = (PlayerVar.player.position - fenrir.position).angle()
	charge_path.set_rotation(angle)
	if charged:
		charge_distance -= 1
		if charge_distance > 0:
			if charge_distance > slowdown_distance:
				t += _delta * 2.4
			else:
				t -= _delta * 1.7
			if t <= 0:
				t = 0
			else:
				.move(lerp(0, SPEED, t), charge_direction)
		else:
			fenrir.get_node("FenrirBody").disabled = false
			emit_signal("finished", "chase")

func _on_ChargeTimer_timeout():
	charged = true
	fenrir.get_node("FenrirBody").disabled = true
	charge_path.visible = false
	angle = (PlayerVar.player.position - fenrir.position).angle()
	animation_player.play("charge_path_charged")
	charge_direction = .get_direction(PlayerVar.player)
	
func exit():
	charged = false

func damage():
	emit_signal("finished", "stagger")


