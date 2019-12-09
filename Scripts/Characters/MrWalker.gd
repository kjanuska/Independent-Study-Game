extends KinematicBody2D

var overlapping = false

func _ready():
	$AnimationPlayer.play("idle")

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		overlapping =  true

func _on_Area2D_body_exited(body):
	if body.get_name() == "Player":
		PlayerVar.player.camera_zoom(1, 1)
		overlapping =  false

func _input(_event):
	if Input.is_action_pressed("Interact") && overlapping:
		PlayerVar.player.camera_zoom(0.5, 0.5)
		$Text.interact()