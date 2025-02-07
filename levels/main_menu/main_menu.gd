extends Control

@onready var start_button: Button = $StartButton


func _on_button_button_up() -> void:
	#get_tree().change_scene_to_file("res://levels/testing/test.tscn")
	get_tree().change_scene_to_file("res://levels/forest/forest.tscn")


func _on_quit_button_up() -> void:
	get_tree().quit()
