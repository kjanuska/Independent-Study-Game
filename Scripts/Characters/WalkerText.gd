extends Node2D

onready var tie = $TextInterfaceEngine

func ready():
	tie.reset()
	tie.set_color("red")
	tie.set_size(11)
func interact():
	tie.reset()
	tie.set_color("black")
	tie.set_size(11)
	tie.buff_text("Hey ", 0.1)
	tie.buff_text("bro\n", 0.4)
	tie.buff_silence(1)
	tie.buff_text("I'm Mr. Walker", 0.05)
	tie.set_state(tie.STATE_OUTPUT)