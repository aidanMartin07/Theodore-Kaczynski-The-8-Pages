extends Node

var rand: RandomNumberGenerator

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rand = RandomNumberGenerator.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
