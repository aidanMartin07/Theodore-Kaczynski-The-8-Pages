extends Node3D

var pipe = preload("res://entities/pipe/pipe.tscn")
const MAX_PIPES = 5

@onready var player_area: Area3D = $Player/CharacterBody3D/PlayerArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(5):
		var w = get_tree().get_root()
		var p = pipe.instantiate()
		p.player_radius = player_area
		w.add_child(p)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
