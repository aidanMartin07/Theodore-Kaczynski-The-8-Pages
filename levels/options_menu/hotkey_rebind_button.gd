class_name HotkeyRebindButton extends Control


@onready var label: Label = $HBoxContainer/Label
@onready var button: Button = $HBoxContainer/Button

@export var action_name: String = "forward"

func _ready() -> void:
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_key()


func set_action_name() -> void:
	label.text = "Unassigned"
	
	match action_name:
		"forward": 
			label.text = "Move Forward"
		"backward":
			label.text = "Move Backward"
		"right":
			label.text = "Move Right"
		"left": 
			label.text = "Move Left"
		"shift":
			label.text = "Sprint"
		"interact":
			label.text = "Interact"
		"flashlight":
			label.text = "Flashlight"
		"Escape":
			label.text = "Pause"

func set_text_for_key() -> void:
	var action_events = InputMap.action_get_events(action_name)
	
	if action_events.size() > 0:
		var action_event = action_events[0]
		if action_event is InputEventKey:
			var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
			button.text = "%s" % action_keycode
		elif action_event is InputEventMouseButton:
			button.text = "Mouse Button %d" % action_event.button_index
		else:
			button.text = "Unsupported Input"
	else:
		button.text = "No Input Event"


func _on_button_toggled(toggled_on: bool) -> void:
	var rebind_buttons : Array[HotkeyRebindButton] = []
	rebind_buttons.append_array(get_tree().get_nodes_in_group("hotkey_button"))
	
	if toggled_on:
		button.text = "Press any key..."
		set_process_unhandled_key_input(toggled_on)
		for rebind_button in rebind_buttons:
			if rebind_button.action_name != self.action_name:
				rebind_button.button.toggle_mode = false
				rebind_button.set_process_unhandled_key_input(false)
	else:
		for rebind_button in rebind_buttons:
			if rebind_button.action_name != self.action_name:
				rebind_button.button.toggle_mode = true
				rebind_button.set_process_unhandled_key_input(false)
		set_text_for_key()

func _unhandled_key_input(event: InputEvent) -> void:
	rebind_action_key(event)
	button.button_pressed = false

func rebind_action_key(event: InputEvent) -> void:
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, event)
	
	set_process_unhandled_key_input(false)
	set_text_for_key()
	set_action_name()
