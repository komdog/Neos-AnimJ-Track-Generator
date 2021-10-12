extends Panel


func _on_Add_button_up():
	if $Beat.value < 0 : return
	if $Value.text.empty() : return

	print('Writing keyframe')

	var seconds = $Beat.value * (60.0/128.0)

	Data.keyframes.append(
		{
			"time": seconds,
			"value": float($Value.text)
		}
	)

	print(Data.keyframes)