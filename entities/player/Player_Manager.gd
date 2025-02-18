extends Node


var page_count = 0
var can_interact: bool = false

var paused = false
var pause_menu = preload("res://levels/pause_menu/pause_menu.tscn")


signal all_pages_collected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(page_count == 8):
		page_count = 9
		emit_signal("all_pages_collected")
