extends ProgressBar

onready var buttons = get_children()


func _ready():
	print(buttons)
	# connect seeker buttons
	for i in buttons.size():
		buttons[i].connect("button_up", get_node("../Music"), "skip_seek", [i])



