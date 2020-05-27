extends Node2D

onready var tie = $TextInterfaceEngine

func ready():
	tie.reset()
	tie.buff_text("!")
	tie.set_state(tie.STATE_OUTPUT)
	tie.set_color(Color(255, 0, 0))
	tie.set_size(11)

func interact():
	tie.reset()
	tie.set_color(Color(0, 0, 0))
	tie.set_size(11)
	tie.buff_text("Hey, I'm in a pickle here.\n", 0.05)
	tie.buff_silence(1)
	tie.clear_text()
	tie.buff_text("There are some slimes over there that I can't", 0.03)
	tie.buff_text(" get rid of because I don't know how to use a sword!", 0.03)
	tie.clear_text()
	tie.buff_text(" Can you get rid of them for me?\n", 0.05)
	tie.clear_text()
	tie.buff_text(" Once you do that, I hear there is a town across the river!", 0.02)
	tie.set_state(tie.STATE_OUTPUT)