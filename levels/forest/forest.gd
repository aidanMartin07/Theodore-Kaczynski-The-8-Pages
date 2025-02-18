extends Node3D

@export var player_node: Node3D

var pipe = preload("res://entities/pipe/pipe.tscn")
const MAX_PIPES = 5



var animal_sounds: Array = [
	preload("res://assets/sounds/slender/cricket1.wav"),
	preload("res://assets/sounds/slender/cricket3.wav"),
	preload("res://assets/sounds/slender/birds1.wav"),
	preload("res://assets/sounds/slender/birds2.wav"),
	preload("res://assets/sounds/slender/birds3.wav"),
	preload("res://assets/sounds/slender/birds4.wav"),
]

var pages: Array 

var transitioning: bool = false
signal start_end

@onready var player_area: Area3D = $Player/CharacterBody3D/PlayerArea

@onready var animal_sound_player: AudioStreamPlayer = $AnimalSounds
@onready var animal_timer: Timer = $AnimalTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerManager.page_count = 0
	PlayerManager.all_pages_collected.connect(next_level)
	
	animal_timer.start(randi_range(1,2))
	
	#system to change page texture depending on pages collected
	#var page_interact = get_node("Player/CharacterBody3D/CameraHolder/Camera3D/InteractRayCast")
	#page_interact.page_found.connect(page_picked_up)
	#
	#pages = get_tree().get_nodes_in_group("page")

	#spawns all pipes	
	for i in range(5):
		var w = get_tree().get_root()
		var p = pipe.instantiate()
		p.player_radius = player_area
		w.add_child(p)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func next_level() -> void:
	SceneTransition.load_new_scene("res://levels/marx/marx.tscn")

#func page_picked_up() -> void:
	#print("page_picked_up")

#func set_page_image(index: int) -> void:
	#pages = get_tree().get_nodes_in_group("page")
		#


func _on_animal_timer_timeout() -> void:
	animal_sound_player.stream = animal_sounds.pick_random()
	animal_sound_player.volume_db = -30
	animal_sound_player.playing = true
	animal_timer.start(randi_range(1,2))
