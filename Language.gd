extends Node

var lang_en: Dictionary = {
	"BackToMainMenu": 'Back to main menu',
	"SelectResolution": '(Select resolution)',
	"VsyncOFF": 'Vsync off',
	"VsyncTraditional": 'Vsync (Traditional)',
	"VsyncAdaptive": 'Vsync (Adaptive)',
	"FpsNoLimit": 'No limit',
	"WindowsMode": 'Windows mode',
	"MaximizedWindow": 'Maximized window',
	"FullscreenMode": 'Fullscreen mode',
	"WindowedFullscreenMode": 'Windowed-Fullscreen',
	"ResetSettings": 'Reset settings',
	"ResetConfirm": 'Are you sure to reset the settings?',
	"Yes": 'Yes',
	"No": 'No',
	"PlayGame": 'Play',
	"PressStart": 'Press to start the game',
	"QuitGame": 'Quit',
	"PressLeave": 'Press to leave the game',
	"Settings": 'Settings',
	"Credits": 'Credits',
	"BugReport": 'Bug Report',
	"Language": 'Languge',
	"BackToGame": 'Back to the game',
	"FovError": 'Error: FOV out of range',
	"Respawn": 'Respawn',
	"DiedMessage": 'You died.',
}
	
var lang_zhTw: Dictionary = {
	"BackToMainMenu": '回到主選單',
	"SelectResolution": '(選擇畫質)',
	"VsyncOFF": '關閉垂直同步',
	"VsyncTraditional": '垂直同步 (傳統)',
	"VsyncAdaptive": '垂直同步 (自適應)',
	"FpsNoLimit": '無限制',
	"WindowsMode": '視窗模式',
	"MaximizedWindow": '最大化視窗',
	"FullscreenMode": '全螢幕模式',
	"WindowedFullscreenMode": '無邊框視窗',
	"ResetSettings": '重製設定',
	"ResetConfirm": '你確定要重製設定嗎？',
	"Yes": '是',
	"No": '否',
	"PlayGame": '開始遊戲',
	"PressStart": '點擊以開始遊戲',
	"QuitGame": '離開遊戲',
	"PressLeave": '點擊以離開遊戲',
	"Settings": '設定',
	"Credits": '感謝名單',
	"BugReport": 'Bug回報',
	"Language": '語言',
	"BackToGame": '回到遊戲',
	"FovError": '錯誤：FOV超過允許範圍',
	"Respawn": '復活',
	"DiedMessage": '你死了。',
}

func languageSelection(lang):
	
	match lang:
		'en':
			return lang_en
		'zh_tw':
			return lang_zhTw
