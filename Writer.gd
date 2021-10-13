extends Panel

onready var music = get_parent().get_node("Music")
onready var frame_list = get_parent().get_node('FrameList')

func _on_Add_button_up():

	if $Beat.value < 0 : return
	if $Value.text.empty() : return

	print('Writing keyframe')

	var seconds = $Beat.value * (60.0/Data.bpm)

	for keyframe in Data.keyframes:
		if keyframe['time'] == seconds:
			return print("Keyframe already assigned")

	Data.keyframes.append(
		{
			"time": seconds,
			"value": float($Value.text)
		}
	)

	resfresh_lish()

func _input(event):
	if !music.playing: return
	if event is InputEventKey:
		if event.is_action_pressed("1"):
			key_assigned(0.25)
		elif event.is_action_pressed("2"):
			key_assigned(0.5)
		elif event.is_action_pressed("3"):
			key_assigned(1)
		elif event.is_action_pressed("4"):
			key_assigned(2)

func key_assigned(value):

	
	var seconds = Data.current_beat * (60.0/Data.bpm)

	for keyframe in Data.keyframes:
		if keyframe['time'] == seconds:
			return print("Keyframe already assigned")


	Data.keyframes.append(
		{
			"time": seconds,
			"value": value
		}
	)

	resfresh_lish()
	

func resfresh_lish():
	frame_list.clear()
	for item in Data.keyframes:
		frame_list.add_item(str(item))
	
	print(Data.keyframes)

	

func _on_BPM_value_changed(value):
	Data.bpm = value


func _on_FrameList_item_rmb_selected(index, _at_position):
	Data.keyframes.remove(index)
	resfresh_lish()
