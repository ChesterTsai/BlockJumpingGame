extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	zoom = Vector2(SaveGame.playerFOV, SaveGame.playerFOV)
	$FOVwarn.visible = false
	$Dead.visible = false

func _input(_ev):
	
	if $Menu.visible == false:
		if zoom.x <= 1.35 and zoom.x >= 0.7:
			$FOVwarn.visible = false
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_DOWN):
				zoom -= Vector2(0.01, 0.01)
			elif Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_UP):
				zoom += Vector2(0.01, 0.01)
		else:
			$FOVwarn.visible = true
			$FOVwarn.set_scale(Vector2(1 / zoom.x, 1 / zoom.y))
		
		SaveGame.playerFOV = zoom.x
		SaveGame.saveGame()
		
	else:
		$Dead.visible = false
		$FOVwarn.visible = false
	
	if Input.is_key_pressed(KEY_ENTER):
		zoom = Vector2(1, 1)

func _process(_delta):
	$Info.position = Vector2((self.position.x - 570) / self.zoom.x, (self.position.y - 136) / self.zoom.y)
	$Info.label_settings.font_size = round(16 / zoom.x)
	$Dead/DeathMessage.label_settings.font_size = round(32 / zoom.x)

func _on_fo_vwarn_pressed():
	$FOVwarn.visible = false
	if zoom.x > 1.35:
		zoom = Vector2(1.349, 1.349)
	if zoom.x < 0.7:
		zoom = Vector2(0.701, 0.701)
	
	SaveGame.playerFOV = zoom.x
	SaveGame.saveGame()


func _on_dead_pressed():
	get_tree().change_scene_to_file("res://world.tscn")
	$Dead.visible = false
