extends Area2D

var speed

var dead_arrow_load = preload("res://Player/Weapons/Ranged/Bow/DeadArrow.tscn")

var direction = Vector2()

func _ready():
	set_as_toplevel(true)

func _physics_process(delta):
	position.x += direction.x * speed * delta * AbilityVar.slowdown
	position.y += direction.y * speed * delta * AbilityVar.slowdown

func set_speed(speed_value):
	speed = speed_value

func _on_VisibilityNotifier2D_screen_exited():
	if speed != 0:
		queue_free()

func _on_Arrow_area_entered(area):
	if area.is_in_group("hurtbox"):
		var dead_arrow = dead_arrow_load.instance()
		area.get_parent().call_deferred("add_child", dead_arrow)
		dead_arrow.set_rotation(get_rotation())
		queue_free()
		area.take_damage(20)
