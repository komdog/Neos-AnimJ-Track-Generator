extends Panel

var _e 

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect items
	_e = $LoadSong.connect('button_up', self, 'get_file')
	_e = $FileDialog.connect('file_selected', self, 'load_ogg')
	_e = $Play.connect('button_up', self, 'control_music', [1])
	_e = $Stop.connect('button_up', self, 'control_music', [0])


func get_file():
	$FileDialog.popup()

func load_ogg(path):

	var ogg_file = File.new() # Instance new File Class
	ogg_file.open(path, File.READ) # Read File
	var bytes = ogg_file.get_buffer(ogg_file.get_len()) # Get data of OGG file in Bytes

	var ogg_stream = AudioStreamOGGVorbis.new() # Instance new Audio Stream
	ogg_stream.data = bytes # Copy Bytes from file to stream data
	ogg_file.close() # Close File

	$Music.stream = ogg_stream
	log_music_data()
	$LineEdit.text = path

func log_music_data():
	print("Song length: %s" % $Music.stream.get_length())
	

func control_music(param):
	$Music.control(param)
