extends CharacterBody3D



var player_visible: bool = false

@export var player_node: CharacterBody3D
@export var player_area: Area3D

var speed: float = 2.0
const wandering_speed: float = 2.0
const chase_speed: float = 2.25


var node_min: Vector3 = Vector3(-76,0,-236)
var node_max: Vector3 = Vector3(265, 0, -20)
#var node_min: Vector3 = Vector3(-31,0,-31)
#var node_max: Vector3 = Vector3(31,0,31)
var next_node: Vector3
var wandering: bool = false

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

func _ready() -> void:
	wandering = false

func _physics_process(delta: float) -> void:
	if(player_visible):
		make_path_to_player()
		speed = chase_speed
	else:
		wander()
		speed = wandering_speed
		
		
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()
	

func wander() -> void:
	#this took way too long rewriting code that all did the same thing but didn't work
	#if already wandering do nothing
	#this first if is useless
	if(wandering):
		return
	else:
		#if not wandering start wandering by choosing random position on map
		wandering = true
		next_node = Vector3(randf_range(node_min.x,node_max.x), 1, randf_range(node_min.z,node_max.z))
		nav_agent.target_position = next_node

func make_path_to_player() -> void: 
	nav_agent.target_position = player_node.global_position
	if(nav_agent.is_navigation_finished()):
		print("at player")


func _on_ted_area_body_entered(body: Node3D) -> void:
	if(body.is_in_group("Player")):
		player_visible = true
		print("player visible")


func _on_ted_area_body_exited(body: Node3D) -> void:
	if(body.is_in_group("Player")):
		player_visible = false
		print("player lost")


func _on_navigation_agent_3d_navigation_finished() -> void:
	wandering = false


func _on_wander_timer_timeout() -> void:
	if(player_visible):
		return
	else:
		wandering = false
