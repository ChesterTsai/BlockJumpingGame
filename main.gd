extends Node2D

func _ready():
	
	#SaveGame.saveGame()
	#when adding new variables in to 'GameUserSettings.txt' file, make it active to re-run the settings
	
	SaveGame.loadGame()
	var windowSizeX = DisplayServer.window_get_size()[0]
	var windowSizeY = DisplayServer.window_get_size()[1]
	var screenSizeX = DisplayServer.screen_get_size()[0]
	var screenSizeY = DisplayServer.screen_get_size()[1]
	
	var windowPositionStartPointX = (screenSizeX - windowSizeX) / 2
	var windowPositionStartPointY = (screenSizeY - windowSizeY) / 2
	
	DisplayServer.window_set_position(Vector2i(windowPositionStartPointX, windowPositionStartPointY))
	
	setLanguage(SaveGame.language)
	
	$SettingsButton/SettingsLabel.visible = false

func setLanguage(lang):
	
	var usingLanguage = Language.languageSelection(lang)
	
	$PLay.text = usingLanguage["PlayGame"]
	$PLay.tooltip_text = usingLanguage["PressStart"]
	$Quit.text = usingLanguage["QuitGame"]
	$Quit.tooltip_text = usingLanguage["PressLeave"]
	$SettingsButton/SettingsLabel.text = usingLanguage["Settings"]
	$Credit/CreditLabel.text = usingLanguage["Credits"]
	$BugReport/BugReportLabel.text = usingLanguage["BugReport"]
	$Languge/LangugeLabel.text = usingLanguage["Language"]

func _process(delta):
	
	var isSettingsButtonHovered = $SettingsButton.is_hovered()
	var isCreditButtonHovered = $Credit.is_hovered()
	var isBugReportButtonHovered = $BugReport.is_hovered()
	var isLanguageSelectButtonHovered = $Languge.is_hovered()
	
	
	
	$SettingsButton/SettingsLabel.visible = isSettingsButtonHovered
	$Credit/CreditLabel.visible = isCreditButtonHovered
	$BugReport/BugReportLabel.visible = isBugReportButtonHovered
	$Languge/LangugeLabel.visible = isLanguageSelectButtonHovered

func _on_p_lay_pressed():
	#OS.shell_open("https://download-porter.hoyoverse.com/download-porter/2023/11/02/GenshinImpact_install_20231018104733.exe?trace_key=GenshinImpact_install_ua_78974bcb97d2")
	get_tree().change_scene_to_file("res://world.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://options.tscn")

func _on_thanks_pressed():
	pass # Replace with function body.

func _on_bug_report_pressed():
	OS.shell_open("https://game-by-chester.webnode.tw/%e8%81%af%e7%b5%a1/")

func _on_languge_pressed():
	get_tree().change_scene_to_file("res://langugeSettings.tscn")
