extends Node2D

func _ready():
	
	var lang = SaveGame.language
	
	setLanguage(lang)
	
	match lang:
		'en':
			$OptionButton.selected = 0
		'zh_tw':
			$OptionButton.selected = 1

func setLanguage(lang):
	
	var usingLanguage = Language.languageSelection(lang)
	
	$BackToMainMenu/BackToMainLabel.text = usingLanguage["BackToMainMenu"]

func _process(delta):
	if $BackToMainMenu.is_hovered():
		$BackToMainMenu/BackToMainLabel.visible = true
	else:
		$BackToMainMenu/BackToMainLabel.visible = false

func _on_back_to_main_menu_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_option_button_item_selected(index):
	match index:
		0:
			SaveGame.language = 'en'
		1:
			SaveGame.language = 'zh_tw'
	
	SaveGame.saveGame()
	get_tree().change_scene_to_file("res://langugeSettings.tscn")
