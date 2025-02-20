extends Control

const WINDOW_MODE_ARRAY: Array[String] = [
	"Window Mode",
	"Borderless Window",
	"Full-Screen",
	"Borderless Full-Screen"
]

@onready var option_button: OptionButton = $HBoxContainer/OptionButton



func _ready() -> void:
	add_window_mode_items()
	option_button.item_selected.connect(on_window_mode_selected)

func add_window_mode_items() -> void:
	for mode in WINDOW_MODE_ARRAY:
		option_button.add_item(mode)

func on_window_mode_selected(index: int) -> void:
	match index:
		0: #windowed mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1: #Borderless windowed mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		2: #fullscreen mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		3: #borderless fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
