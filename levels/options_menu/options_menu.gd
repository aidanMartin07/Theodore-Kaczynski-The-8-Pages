extends Control

signal exit_options_menu

@export var exit_button: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_exit_button_up() -> void:
	exit_options_menu.emit()
	set_process(false)
