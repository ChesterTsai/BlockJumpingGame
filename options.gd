extends Node2D

func _ready():
	
	$ResetButton/ResetWarning.visible = false
	
	var currentResolutionX = DisplayServer.window_get_size()[0]
	var currentResolutionY = DisplayServer.window_get_size()[1]
	
	if currentResolutionX == 854 and currentResolutionY == 480:
		$Resolution.selected = 1
	elif currentResolutionX == 1280 and currentResolutionY == 720:
		$Resolution.selected = 2
	elif currentResolutionX == 1600 and currentResolutionY == 900:
		$Resolution.selected = 3
	elif currentResolutionX == 1920 and currentResolutionY == 1080:
		$Resolution.selected = 4
	else:
		$Resolution.selected = 0
	
	
	$Vsync.selected = DisplayServer.window_get_vsync_mode()
	
	
	var maxFpsSelected: Dictionary = {
		20: 0,
		30: 1,
		48: 2,
		60: 3,
		120: 4,
		144: 5,
		0: 6
	}
	$FPS.selected = maxFpsSelected[Engine.max_fps]
	
	
	var selectedWindowMode: Dictionary = {
		0: "WINDOWED & MAXIMIZED",
		3: "FULLSCREEN",
		4: "EXCLUSIVE_FULLSCREEN"
	}
	match DisplayServer.window_get_mode():
		"WINDOWED & MAXIMIZED":
			var WINDOWED_MODE = currentResolutionX != DisplayServer.screen_get_size()[0]
			if WINDOWED_MODE:
				$windowMode.selected = 0
			else:
				$windowMode.selected = 1
		"FULLSCREEN":
			$windowMode.selected = 2
		"EXCLUSIVE_FULLSCREEN":
			$windowMode.selected = 3
	
	setLanguage(SaveGame.language)

func setLanguage(lang):
	
	var usingLanguage = Language.languageSelection(lang)
	
	$BackToMainMenu/BackToMainLabel.text = usingLanguage["BackToMainMenu"]
	$Resolution.set_item_text(0, usingLanguage["SelectResolution"])
	$Vsync.set_item_text(0, usingLanguage["VsyncOFF"])
	$Vsync.set_item_text(1, usingLanguage["VsyncTraditional"])
	$Vsync.set_item_text(2, usingLanguage["VsyncAdaptive"])
	$FPS.set_item_text(6, usingLanguage["FpsNoLimit"])
	$windowMode.set_item_text(0, usingLanguage["WindowsMode"])
	$windowMode.set_item_text(1, usingLanguage["MaximizedWindow"])
	$windowMode.set_item_text(2, usingLanguage["FullscreenMode"])
	$windowMode.set_item_text(3, usingLanguage["WindowedFullscreenMode"])
	$ResetButton.text = usingLanguage["ResetSettings"]
	$ResetButton/ResetWarning.title = usingLanguage["ResetConfirm"]
	$ResetButton/ResetWarning.set_item_text(0, usingLanguage["Yes"])
	$ResetButton/ResetWarning.set_item_text(1, usingLanguage["No"])
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	var isBackToMainMenuButtonHovered = $BackToMainMenu.is_hovered()
	
	$BackToMainMenu/BackToMainLabel.visible = isBackToMainMenuButtonHovered

func _input(_event):
	
	var isEscapeKeyPressed = Input.is_key_pressed(KEY_ESCAPE)
	
	if isEscapeKeyPressed:
		get_tree().change_scene_to_file("res://main.tscn")

func _on_back_to_main_menu_pressed():
	get_tree().change_scene_to_file("res://main.tscn")

func _on_resolution_item_selected(_index):
	
	var windowSizeX = 0
	var windowSizeY = 0
	var screenSizeX = DisplayServer.screen_get_size()[0]
	var screenSizeY = DisplayServer.screen_get_size()[1]
	
	var selectedResolution: Dictionary = {
		0: "1152x648",
		1: "854x480",
		2: "1280x720",
		3: "1600x900",
		4: "1920x1080"
	}
	
	var getSelectedResolution = selectedResolution[$Resolution.get_selected_id()]
	
	match getSelectedResolution:
		"1152x648":
			windowSizeX = 1152
			windowSizeY = 648
		"854x480":
			windowSizeX = 854
			windowSizeY = 480
		"1280x720":
			windowSizeX = 1280
			windowSizeY = 720
		"1600x900":
			windowSizeX = 1600
			windowSizeY = 900
		"1920x1080":
			windowSizeX = 1920
			windowSizeY = 1080
	
	var windowPositionX = (screenSizeX - windowSizeX) / 2
	var windowPositionY = (screenSizeY - windowSizeY) / 2
	
	DisplayServer.window_set_size(Vector2i(windowSizeX, windowSizeY))
	DisplayServer.window_set_position(Vector2i(windowPositionX, windowPositionY), 0)
	SaveGame.saveGame()


func _on_vsync_item_selected(_index):
	
	var vsyncMode: Dictionary = {
		0: DisplayServer.VSYNC_DISABLED,
		1: DisplayServer.VSYNC_ENABLED,
		2: DisplayServer.VSYNC_ADAPTIVE
	}
	
	var getVsyncMode = vsyncMode[$Vsync.get_selected_id()]
	
	DisplayServer.window_set_vsync_mode(getVsyncMode)
	
	SaveGame.saveGame()


func _on_fps_item_selected(_index):
	
	var getMaxFpsSelect = $FPS.get_selected_id()
	
	var maxFpsSelect: Dictionary = {
		0: 20,
		1: 30,
		2: 48,
		3: 60,
		4: 120,
		5: 144,
		6: 0
	}
	
	Engine.max_fps = maxFpsSelect[getMaxFpsSelect]
	
	SaveGame.saveGame()
	


func _on_window_mode_item_selected(index):
	
	var selectedWindowMode: Dictionary = {
		0: "WINDOWED",
		1: "MAXIMIZED",
		2: "FULLSCREEN",
		3: "EXCLUSIVE_FULLSCREEN"
	}
	
	var getSelectedWindowMode = selectedWindowMode[$windowMode.get_selected_id()]
	
	match getSelectedWindowMode:
		"WINDOWED":
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		"MAXIMIZED":
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		"FULLSCREEN":
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		"EXCLUSIVE_FULLSCREEN":
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	
	SaveGame.saveGame()


func _on_reset_button_pressed():
	$ResetButton/ResetWarning.visible = true


func _on_reset_warning_id_pressed(id):
	
	var isResetDenied = id
	
	if isResetDenied:
		$ResetButton/ResetWarning.visible = false
		return
	
	SaveGame.defaultSetting()
	get_tree().change_scene_to_file("res://main.tscn")
