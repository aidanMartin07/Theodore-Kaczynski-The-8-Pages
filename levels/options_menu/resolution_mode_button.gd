extends Control

@onready var option_button: OptionButton = $HBoxContainer/OptionButton

const RESOLUTIONS: Dictionary = {
	"1152 x 648" : Vector2i(1152, 648),
	"1280 x 720" : Vector2i(1280,720),
	"1600 x 900" : Vector2i(1600, 900),
	"1920 x 1080" : Vector2i(1920,1080),
}



func _ready() -> void:
	add_resolution_items()
	option_button.item_selected.connect(on_resolution_selected)

func add_resolution_items() -> void:
	for res in RESOLUTIONS:
		option_button.add_item(res)

func on_resolution_selected(index: int) -> void:
	#DisplayServer.window_set_size(RESOLUTIONS.values()[index])
	match index:
		0: 
			DisplayServer.window_set_size(RESOLUTIONS["1152 x 648"])
		1: 
			DisplayServer.window_set_size(RESOLUTIONS["1280 x 720"])
		2:
			DisplayServer.window_set_size(RESOLUTIONS["1600 x 900"])
		3: 
			DisplayServer.window_set_size(RESOLUTIONS["1920 x 1080"])
