extends Control

@onready var start_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/StartButton
@onready var options_menu: Control = $OptionsMenu
@onready var margin_container: MarginContainer = $MarginContainer

func _ready() -> void:
	options_menu.exit_options_menu.connect(on_exit_options_menu)


func _on_button_button_up() -> void:
	#get_tree().change_scene_to_file("res://levels/testing/test.tscn")
	#SceneTransition.load_new_scene("res://levels/forest/forest.tscn")
	get_tree().change_scene_to_file("res://levels/forest/forest.tscn")


func _on_quit_button_up() -> void:
	get_tree().quit()

func on_exit_options_menu() -> void:
	margin_container.visible = true
	options_menu.visible =false


func _on_options_button_up() -> void:
	margin_container.visible = false
	options_menu.visible = true
	options_menu.set_process(true)
