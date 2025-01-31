extends CanvasLayer

@onready var page_count: RichTextLabel = $PageCount

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	page_count.text = "Pages: " + str(PlayerManager.page_count)
