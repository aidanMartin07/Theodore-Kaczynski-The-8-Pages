extends RayCast3D

signal page_found
@onready var paper_grab: AudioStreamPlayer3D = $PaperGrab

func _process(delta: float) -> void:
	if(is_colliding()):
		var obj = get_collider()
		if(Input.is_action_just_pressed("interact")):
			emit_signal("page_found")
			PlayerManager.page_count += 1
			paper_grab.playing = true
			obj.get_parent().queue_free()
