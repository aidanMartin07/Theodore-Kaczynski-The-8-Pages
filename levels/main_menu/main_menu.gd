extends Control

@onready var button: Button = $Button


func _on_button_button_up() -> void:
	get_tree().change_scene_to_file("res://levels/forest/forest.tscn")
