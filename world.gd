extends Node2D

func _ready():
	$CharacterBody2D/Camera2D/Menu.visible = false
	$CharacterBody2D/Camera2D/Back.visible = false
	
	setLanguage(SaveGame.language)

func setLanguage(lang):
	
	var usingLanguage = Language.languageSelection(lang)
	
	$CharacterBody2D/Camera2D/Menu.text = usingLanguage["BackToMainMenu"]
	$CharacterBody2D/Camera2D/Back.text = usingLanguage["BackToGame"]
	$CharacterBody2D/Camera2D/FOVwarn.text = usingLanguage["FovError"]
	$CharacterBody2D/Camera2D/FOVwarn.tooltip_text = usingLanguage["Yes"]
	$CharacterBody2D/Camera2D/Dead.text = usingLanguage["Respawn"]
	$CharacterBody2D/Camera2D/Dead/DeathMessage.text = usingLanguage["DiedMessage"]


func _input(_ev):
	
	var isEscapeKeyPressed = Input.is_key_pressed(KEY_ESCAPE)
	var isMenuButtonVisible = $CharacterBody2D/Camera2D/Menu.visible
	
	
	if isEscapeKeyPressed and !isMenuButtonVisible:
		$CharacterBody2D/Camera2D/Menu.visible = true
		$CharacterBody2D/Camera2D/Back.visible = true
	elif isEscapeKeyPressed:
		$CharacterBody2D/Camera2D/Menu.visible = false
		$CharacterBody2D/Camera2D/Back.visible = false

func _process(delta):
	$Void.position = Vector2($CharacterBody2D.position.x, 2400)
	
	# Weird fomula to calculate current FOV
	var currentFOV = round(-70 * $CharacterBody2D/Camera2D.zoom.x + 170)
	var currentFPS = Engine.get_frames_per_second()
	var currentXposition = round($CharacterBody2D.position.x)
	var currentYposition = round($CharacterBody2D.position.y)
	
	var infoText = $CharacterBody2D/Camera2D/Info
	
	#INFO Label
	infoText.text = "FOV: " + str(currentFOV)
	infoText.text = str(infoText.text) + "\nFPS: " + str(currentFPS)
	infoText.text = str(infoText.text) + "\nX: " + str(currentXposition)
	infoText.text = str(infoText.text) + " Y: " + str(currentYposition)

func _on_back_pressed():
	$CharacterBody2D/Camera2D/Menu.visible = false
	$CharacterBody2D/Camera2D/Back.visible = false


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
