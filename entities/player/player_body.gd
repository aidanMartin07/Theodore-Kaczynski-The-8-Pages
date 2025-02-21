extends CharacterBody3D



const WALK_SPEED: float = 2.0 # default 0f 2.0
const SPRINT_SPEED: float = 21.0 #default of 4.0
const JUMP_VELOCITY:float = 4.5
const SENSITIVITY:float = 0.0018

const BASE_FOV: float = 75.0
const FOV_CHANGE: float = 1.1
#headbob vars
const BOB_FREQ: float = 1.75
const BOB_AMP_VERT: float = 0.06
const BOB_AMP_HORIZONTAL: float = 0.06
var t_bob = 0.0

var gravity: float = 12.0
var speed: float = 0.0

var slowed: bool = false
var can_sprint: bool = true
const SPRINT_MAX: int = 200
var sprint_drain: int = 0 # default 45
var sprint_gain: int = 30 #30 to let it gain
var sprinting: bool = false
var moving: bool = false

var can_regen: bool = false
var start_regen: bool = false

var flash_on: bool = true

var paused = false

var curr_material: String
#Footstep system variables
var can_play: bool = false
signal step
var footstep_grass_run: Array = [
	preload("res://assets/sounds/slender/step1_run.wav"),
	preload("res://assets/sounds/slender/step2_run.wav"),
]
var footstep_building: Array = [
	preload("res://assets/sounds/slender/tilestep2.wav"),
	preload("res://assets/sounds/slender/tilestep3.wav")
]

var static_effect = preload("res://entities/static/static.tscn")

@export var ted: CharacterBody3D

@onready var head: Node3D = $CameraHolder
@onready var camera: Camera3D = $CameraHolder/Camera3D
@onready var flashlight: SpotLight3D = $CameraHolder/Camera3D/Flashlight
@onready var sprint_bar: TextureProgressBar = $"../HUD/SprintBar"
@onready var sprint_gain_timer: Timer = $"../SprintGainTimer"
@onready var flashlight_model: Node3D = $CameraHolder/Camera3D/flashlight_model
@onready var hud: CanvasLayer = $"../HUD"
@onready var player: Node3D = $".."
@onready var footstep_player: AudioStreamPlayer3D = $Footsteps
@onready var pipe_timer: Timer = $"../PipeTimer"
@onready var ground_position: Marker3D = $GroundPosition
@onready var flashlight_click: AudioStreamPlayer3D = $CameraHolder/Camera3D/Flashlight/FlashlightClick
@onready var player_area_shape: CollisionShape3D = $PlayerArea/CollisionShape3D

func _ready():
	sprint_bar.value = SPRINT_MAX
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	ted.player_caught.connect(caught)
	var pipes = get_tree().get_nodes_in_group("pipe")
	for pipe in pipes:
		pipe.exploded.connect(slow)


func caught() -> void:
	hud.add_child(static_effect.instantiate())
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("Escape") and paused == false):
		open_pause_menu()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	
	
	if(start_regen and can_regen):
		sprint_bar.value += sprint_gain * delta
	
	if(sprint_bar.value == 200):
		can_regen = false
		start_regen = false
	
	if(sprint_bar.value != 0):
		can_regen = true
		can_sprint = true
	
	if(sprint_bar.value == 0):
		can_sprint = false
	
	if(Input.is_action_pressed("shift") and can_sprint):
		if(sprint_bar.value > 0 ):
			start_regen = false
			can_regen = false
			sprint_bar.value -= sprint_drain * delta
	
	if(Input.is_action_just_released("shift")):
		sprint_gain_timer.start(3)
	
	if(Input.is_action_just_pressed("flashlight")):
		flash_on = !flash_on
		flashlight_click.playing = true
		if(flash_on):
			flashlight.light_energy = 4
		else:
			flashlight.light_energy = 0
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	
	if (Input.is_action_pressed("shift") and can_sprint):
		speed = SPRINT_SPEED
		player_area_shape.shape.radius = lerp(float(player_area_shape.shape.radius),55.0,delta * 9.0)
		#print(player_area_shape.shape.radius)
		#print(player_area_shape.shape.radius)
		#flashlight.rotation.x = lerp_angle(-0.7, 0.0, delta *10.0)
	else:
		speed = WALK_SPEED
		player_area_shape.shape.radius = 25
		#print(player_area_shape.shape.radius)

		#print(player_area_shape.shape.radius)

		#flashlight.rotation.x = lerp_angle(-0.0, -0.7, delta* 10.0)
	
	
	if(slowed ):
		speed = 0.75
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 9.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 9.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)
	#HeadBobbing
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	
	#fov
	var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED *2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)

	if(input_dir.x != 0 or input_dir.y != 0):
		moving = true
	else:
		moving = false

	#if(moving and !footstep_player.playing and is_on_floor() and camera.transform.origin.y == 0.06):
		#footstep_player.stream = footstep_grass_run.pick_random()
		#footstep_player.pitch_scale = randf_range(0.9,1.1)
		#footstep_player.play()
	#if not moving and footstep_player.playing:
		#footstep_player.stop()
		#
	move_and_slide()

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	#pos = Vector3(0,0.6,0)
	pos.y += sin(time*BOB_FREQ) * BOB_AMP_VERT
	pos.x = cos(time * BOB_FREQ /2 ) * BOB_AMP_HORIZONTAL
	
	var low_pos = BOB_AMP_VERT - 0.03 
	if pos.y > -low_pos:
		can_play = true
		
	if pos.y < -low_pos and can_play:
		can_play = false
		emit_signal("step")
	
	pos.y += 0.6
	return pos

func open_pause_menu():
	var pause_menu = load("res://levels/pause_menu/pause_menu.tscn").instantiate()
	paused = true
	hud.add_child(pause_menu)

func _on_sprint_gain_timer_timeout() -> void:
	start_regen = true
	can_regen = true

func slow() -> void:
	slowed = true
	pipe_timer.start()


func _on_pipe_timer_timeout() -> void:
	slowed = false
