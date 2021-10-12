extends Control


onready var info_panel = $Fields/Info
onready var generate_button = $Fields/Generate

var fields = []

var params = [
	'name',
	'valueType',
	'node',
	'property',
]

# Called when the node enters the scene tree for the first time.
func _ready():

	# Connect generate button
	generate_button.connect("button_up", self, "generate_pressed")

	# Create fields from params
	for p in params:
		create_field(p)

	print(fields)


func create_field(name: String):

	var hbox = HBoxContainer.new()
	hbox.set_anchors_preset(10)
	info_panel.add_child(hbox)

	var label = Label.new()
	label.align = 1
	label.text = name
	hbox.add_child(label)

	var line_edit = LineEdit.new()
	line_edit.size_flags_horizontal = 3
	hbox.add_child(line_edit)

	fields.append(line_edit)



func generate_pressed():

	# Create json object
	var object = {
		"name": fields[0].text,
		"globalDuration": 0,
		"tracks": [
			{
				"trackType": "Discrete",
				"valueType": fields[1].text,
				"data": {
					"node": fields[2].text,
					"property": fields[3].text,
					"keyframes": Data.keyframes
				}
			}
		]
	}

	generate_button.generate_json(object)
