extends Resource

class_name PlayerKeybindResource

const FORWARD: String = "forward"
const BACKWARD: String = "backward"
const LEFT: String = "left"
const RIGHT: String = "right"
const SHIFT: String = "shift"
const INTERACT: String = "interact"
const FLASHLIGHT: String = "flashlight"

@export var DEFAULT_FORWARD_KEY = InputEventKey.new()
@export var DEFAULT_BACKWARD_KEY = InputEventKey.new()
@export var DEFAULT_LEFT_KEY = InputEventKey.new()
@export var DEFAULT_RIGHT_KEY = InputEventKey.new()
@export var DEFAULT_SHIFT_KEY = InputEventKey.new()
@export var DEFAULT_INTERACT_KEY = InputEventKey.new()
@export var DEFAULT_FLASHLIGHT_KEY = InputEventKey.new()

var forward_key = InputEventKey.new()
var backward_key = InputEventKey.new()
var left_key = InputEventKey.new()
var right_key = InputEventKey.new()
var shift_key = InputEventKey.new()
var interact_key = InputEventKey.new()
var flashlight_key = InputEventKey.new()
