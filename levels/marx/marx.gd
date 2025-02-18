extends Node3D

@export var marx: CharacterBody3D
@export var player: Camera3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func _on_main_menu_button_up() -> void:
	get_tree().change_scene_to_file("res://levels/main_menu/main_menu.tscn")


func _on_quit_button_up() -> void:
	get_tree().quit()
