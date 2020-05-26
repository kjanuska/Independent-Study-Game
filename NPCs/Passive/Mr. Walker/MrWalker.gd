extends KinematicBody2D

var overlapping = false

var slowdown

func _ready():
	$Text/TextInterfaceEngine.connect("buff_end", self, "stopped_talking")
	$AnimationPlayer.play("idle")
	$ExclamationAnimation.play("ready")

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		overlapping =  true

func _on_Area2D_body_exited(body):
	if body.get_name() == "Player":
		get_node("Text").tie.clear_buffer()
		get_node("Text").tie.clear_text()
		get_node("Text").tie.buff_clear()
		$AnimationPlayer.play("idle")
		PlayerVar.player.camera_zoom(1, 1)
		overlapping =  false

func _input(_event):
	if Input.is_action_pressed("Interact") && overlapping:
		$AnimationPlayer.play("talk")
		$ExclamationMark.hide()
		PlayerVar.player.camera_zoom(0.5, 0.5)
		$Text.interact()

func stopped_talking():
	$AnimationPlayer.play("idle")