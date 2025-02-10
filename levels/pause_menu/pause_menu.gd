extends Control

signal menu_closed

@export var player: Node3D

func _ready() -> void:
	if(get_node_or_null("/root/Forest/Player") != null): 
		player = get_node("/root/Forest/Player/CharacterBody3D")
	get_tree().paused = true

func resume():
	get_tree().paused = false
	player.paused = false
	self.queue_free()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("Escape")):
		resume()

func pause():
	get_tree().paused = true

func _on_resume_button_up() -> void:
	resume()

func _on_button_button_up() -> void:
	get_tree().change_scene_to_file("res://levels/main_menu/main_menu.tscn")


func _on_quit_button_up() -> void:
	get_tree().quit()
