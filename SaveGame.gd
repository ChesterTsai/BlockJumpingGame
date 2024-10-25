extends Node

const SAVE_PATH = "user://GameUserSettings.txt"
var playerFOV = 1
var language = 'en'

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	
	var data: Dictionary = {
		"resolutionX": DisplayServer.window_get_size()[0],
		"resolutionY": DisplayServer.window_get_size()[1],
		"fps_max": Engine.max_fps,
		"vsync": DisplayServer.window_get_vsync_mode(),
		"windowMode": DisplayServer.window_get_mode(),
		"fov": playerFOV,
		"lang": language,
	}
	
	var jstr = JSON.stringify(data)
	file.store_line(jstr)
	
func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	
	if not FileAccess.file_exists(SAVE_PATH):
		return
	
	if file.eof_reached():
		return
	
	var currentLine = JSON.parse_string(file.get_line())
	if not currentLine:
		return
	
	
	
	DisplayServer.window_set_size(Vector2i(currentLine["resolutionX"], currentLine["resolutionY"]))
	Engine.max_fps = currentLine["fps_max"]
	DisplayServer.window_set_vsync_mode(currentLine["vsync"])
	DisplayServer.window_set_mode(currentLine["windowMode"])
	playerFOV = currentLine["fov"]
	language = currentLine["lang"]
	
func defaultSetting():
	DisplayServer.window_set_size(Vector2i(1152, 648))
	Engine.max_fps = 60
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	playerFOV = 1
	language = 'en'
	saveGame()
