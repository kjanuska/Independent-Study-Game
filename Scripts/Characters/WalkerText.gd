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
	tie.buff_text("Hey ", 0.1)
	tie.buff_text("brrrooo\n", 0.9)
	tie.buff_silence(1)
	tie.buff_text("I'm Mr. Walker", 0.05)
	tie.set_state(tie.STATE_OUTPUT)