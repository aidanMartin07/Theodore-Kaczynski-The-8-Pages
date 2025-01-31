extends Node3D

class_name Page

var mat_1 = preload("res://assets/images/Reward_Poster.jpg")

@onready var page_mesh: MeshInstance3D = $MeshInstance3D
@export var page_material: StandardMaterial3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	page_mesh.set_surface_override_material(0, page_material)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
