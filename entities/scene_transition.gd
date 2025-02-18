extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	color_rect.visible = false

func load_new_scene(new_scene: String) -> void:
	animation_player.play("Fade")
	audio_stream_player.play()
	await animation_player.animation_finished
	get_tree().change_scene_to_file(new_scene)
	animation_player.play_backwards("Fade")

func reload_scene() -> void:
	pass
