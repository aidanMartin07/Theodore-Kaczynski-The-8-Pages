extends Node3D

var explosion = preload("res://entities/explosion/explosion.tscn")
@export var player_radius: Area3D

@onready var area_3d: Area3D = $Cube/Area3D

var spawn_min: Dictionary = {
	"x": -76,
	"z": -236
} 

var spawn_max: Dictionary = {
	"x": 265,
	"z": -20
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#global_position = Vector3(0,0,-6)
	respawn()

func respawn() -> void:
	var spawn_x = int(randf_range(spawn_min["x"], spawn_max["x"]))
	var spawn_z = int(randf_range(spawn_min["z"], spawn_max["z"]))
	global_position = Vector3(spawn_x, 0, spawn_z)
	global_rotation.y= randf_range(deg_to_rad(30), deg_to_rad(180))
	print(str(global_position))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_explode() -> void:
	var w = get_tree().get_root()
	var e = explosion.instantiate()
	e.global_transform = self.global_transform
	w.add_child(e)
	queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if(body.is_in_group("Player")):
		start_explode()

func _on_respawn_timer_timeout() -> void:
	if(area_3d.get_overlapping_areas().size() == 0):
		print("respawned")
		respawn()
	else:
		print("player in bound")
