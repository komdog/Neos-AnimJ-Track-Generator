extends AudioStreamPlayer

enum {STOP,PLAY}
var pause_pos: float = 0

var song_position = 0.0

var last_half_beat : float = 0.0 

func _ready():
	volume_db = -6

func control(param):
	# Play Song
	if param == PLAY:
		if playing:
			# Save position when paused
			pause_pos = get_playback_position()
			stop()
		else:
			# Play fromm last position
			play()
			seek(pause_pos)
	# Stop Song
	elif param == STOP:
		pause_pos = 0
		stop()
		reset_UI()

func reset_UI():
	Data.current_beat = 0
	last_half_beat = 0.0
	get_parent().get_node("Beat").text = "Current Beat : 0"
	get_parent().get_node("Pos").text = "Song Position : 0"



func _process(_delta):
		
	if playing: 
		#Get song position & Account for Latency
		song_position = (
			get_playback_position() 
			+ AudioServer.get_time_since_last_mix()
			- AudioServer.get_output_latency()
		)

		get_parent().get_node("Pos").text = "Song Position : %s" % song_position

		var half_beat = int(song_position / (60.0/Data.bpm))
		
		if half_beat > last_half_beat:
			Data.current_beat = half_beat
			get_parent().get_node("Beat").text = "Current Beat : %s" % Data.current_beat

		get_parent().get_node("Seeker").value = (song_position/ Data.song_length)

		
func _on_HSlider_value_changed(value:float):
	print(value)
	volume_db = value

func skip_seek(index):
	if !playing: return

	var value = -3 if index == 0 else 3


	var current_pos = get_playback_position()
	seek(current_pos + value)

