extends "../Motion.gd"

var attack_misses = randi() % 3 + 2

var damaged = false

var damage = 40

func _ready():
	SignalManager.connect("take_damage", self , "damage")

func enter():
	attack_misses -= 1
	aim()
	animation_player.play("attack")

func update(_delta):
	return

func aim():
	var aim = fenrir.get_node("AimSights")
	aim.cast_to = (fenrir.target.position - fenrir.position)
	aim.force_raycast_update()
	fenrir.get_node("Claw").set_rotation(aim.cast_to.normalized().angle())
	distance = fenrir.get_global_position().distance_to(PlayerVar.player.get_global_position())

func _on_AttackTimer_timeout():
		fenrir.get_node("Timers").get_node("AttackTimer").start()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		if damaged:
			damaged = false
			emit_signal("finished", "run_away")
		else:
			aim()
			if distance > 50:
				emit_signal("finished", "chase")
			else:
				animation_player.play("attack")

func damage():
	emit_signal("finished", "stagger")

func _on_AttackBox_area_entered(area):
	if area.is_in_group("hurtbox"):
		damaged = true
		area.take_damage(damage)

