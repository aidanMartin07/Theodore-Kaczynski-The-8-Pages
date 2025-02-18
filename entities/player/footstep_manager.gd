extends Node3D

var footstep_grass: Array = [
	preload("res://assets/sounds/slender/step1.wav"),
	preload("res://assets/sounds/slender/step2.wav"),
]
var footstep_building: Array = [
	preload("res://assets/sounds/slender/tilestep2.wav"),
	preload("res://assets/sounds/slender/tilestep3.wav")
]
@onready var ground_position: Marker3D = $"../GroundPosition"
@onready var player: CharacterBody3D = $".."
@onready var floor_check: RayCast3D = $"../FloorCheck"

var current_footstep: Array


func _ready() -> void:
	player.step.connect(play_sound)

func _physics_process(delta: float) -> void:
	var obj = floor_check.get_collider()
	if obj is GridMap:
		current_footstep = footstep_grass
	else:
		current_footstep = footstep_building

func play_sound() -> void:
	var audio_player: AudioStreamPlayer3D = AudioStreamPlayer3D.new()
	var rand_index: int = randi_range(0, current_footstep.size() -1)
	audio_player.stream = current_footstep[rand_index]
	audio_player.pitch_scale = randf_range(0.8,1.2)
	ground_position.add_child(audio_player)
	audio_player.play()
	audio_player.finished.connect(func destroy(): audio_player.queue_free())
