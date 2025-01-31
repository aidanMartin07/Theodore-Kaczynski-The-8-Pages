extends RayCast3D

signal page_found

func _process(delta: float) -> void:
	if(is_colliding()):
		var obj = get_collider()
		if(Input.is_action_just_pressed("interact")):
			PlayerManager.page_count += 1
			obj.get_parent().queue_free()
