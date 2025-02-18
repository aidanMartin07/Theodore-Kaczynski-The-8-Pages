extends CanvasLayer

@onready var page_count: RichTextLabel = $PageCount
@onready var coords: RichTextLabel = $Coords
@onready var body: CharacterBody3D = $"../CharacterBody3D"
@onready var camera_3d: Camera3D = $"../CharacterBody3D/CameraHolder/Camera3D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(PlayerManager.page_count > 8):
		page_count.text = "Pages: 8"
	else:
		page_count.text = "Pages: " + str(PlayerManager.page_count)
	coords.text = "position: " + str(body.global_position) + "\n" + str(Engine.get_frames_per_second())
	#+ "\n " + str(camera_3d.position.y)
