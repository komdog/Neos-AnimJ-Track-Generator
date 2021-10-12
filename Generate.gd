extends Button


func generate_json(object):
	print("Generating JSON")
	var format = JSON.print(object, '\t')

	var file = File.new()
	file.open("user://%s.animj" % object['name'], File.WRITE)
	file.store_string(format)
	file.close()

	var _e = OS.shell_open(ProjectSettings.globalize_path(("user://")))
