extends Control


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/main_menu/main_menu.tscn")
