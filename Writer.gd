extends Panel


func _on_Add_button_up():
	if $Beat.value < 0 : return
	if $Value.text.empty() : return

	print('Writing keyframe')

	var seconds = $Beat.value * (60.0/Data.bpm)

	Data.keyframes.append(
		{
			"time": seconds,
			"value": float($Value.text)
		}
	)

	get_parent().get_node('FrameList').add_item("Time : %s | Value : %s" % [seconds,$Value.text])

	print(Data.keyframes)

func _on_BPM_value_changed(value):
	Data.bpm = value