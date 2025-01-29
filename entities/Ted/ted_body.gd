extends CharacterBody3D


@export var player_node: CharacterBody3D

const SPEED = 1.5

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

func _physics_process(delta: float) -> void:
	make_path()
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * SPEED
	move_and_slide()
	

func make_path() -> void: 
	nav_agent.target_position = player_node.global_position
	
