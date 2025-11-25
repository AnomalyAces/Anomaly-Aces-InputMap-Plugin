@tool
@icon("res://addons/anomalyAcesInputMap/AceInputMap/AceInputMap.svg")
class_name AceInputMap extends Node

## Controls Camera(s) that should be active [br]
## [b]PLAYER[/b] - Enable player Inputs [br]
## [b]CAMERA[/b] - Enable camera Inputs [br]
## [b]CAMERA_MANAGER[/b] - Enable camera manager Inputs
enum INPUT_MODE {PLAYER, CAMERA, CAMERA_MANAGER}

@export var input_mode: INPUT_MODE = INPUT_MODE.PLAYER

@export var north_input: String :
	set(p_north):
		north_input = p_north
		update_configuration_warnings()
		_input_map_valid = _is_input_map_valid()
@export var east_input: String :
	set(p_east):
		east_input = p_east
		update_configuration_warnings()
		_input_map_valid = _is_input_map_valid()
@export var south_input: String:
	set(p_south):
		south_input = p_south
		update_configuration_warnings()
		_input_map_valid = _is_input_map_valid()
@export var west_input: String :
	set(p_west):
		west_input = p_west
		update_configuration_warnings()
		_input_map_valid = _is_input_map_valid()
@export_category("Camera Inputs")
@export var camera_rotate_input: String :
	set(p_cam_rotate):
		camera_rotate_input = p_cam_rotate
		update_configuration_warnings()
		_input_map_valid = _is_input_map_valid()
@export var camera_zoom_in_input: String :
	set(p_zoom_in):
		camera_zoom_in_input = p_zoom_in
		update_configuration_warnings()
		_input_map_valid = _is_input_map_valid()
@export var camera_zoom_out_input: String :
	set(p_zoom_out):
		camera_zoom_out_input = p_zoom_out
		update_configuration_warnings()
		_input_map_valid = _is_input_map_valid()
@export var camera_pan_input: String :
	set(p_cam_pan):
		camera_pan_input = p_cam_pan
		update_configuration_warnings()
		_input_map_valid = _is_input_map_valid()
@export_category("Camera Manager Inputs")
@export var toggle_camera_mode_input: String :
	set(p_toggleMode):
		toggle_camera_mode_input = p_toggleMode
		update_configuration_warnings()
		_input_map_valid = _is_input_map_valid()


var _input_map_valid: bool = false

func _ready() -> void:
	_input_map_valid = _is_input_map_valid()
	if Engine.is_editor_hint():
		var custom_inputs: Array[String] = []
		custom_inputs.assign([north_input, east_input, south_input, west_input].filter(func(input: String): return !input.is_empty()))
		AceLog.printLog(["Adding Temp Actions to Editor InputMap to quiet errors"])
		AceLog.printLog(["=========Project Settings==========="])
		for input in custom_inputs:
			AceLog.printLog(["Adding %s" % input])
			InputMap.add_action(input)
		AceLog.printLog(["===================================="])


func get_input_vector() -> Vector2:
	return Input.get_vector(west_input, east_input, north_input, south_input)


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray
	#Check Input 
	if input_mode == INPUT_MODE.CAMERA_MANAGER:
		if toggle_camera_mode_input.is_empty():
			warnings.append("toggle camera mode input is empty")
	else:
		if north_input.is_empty():
			warnings.append("north input is empty")
		if east_input.is_empty():
			warnings.append("east input is empty")
		if south_input.is_empty():
			warnings.append("south input is empty")
		if west_input.is_empty():
			warnings.append("west input is empty")
		if input_mode == INPUT_MODE.CAMERA:
			if camera_rotate_input.is_empty():
				warnings.append("camera rotate input is empty")
			if camera_zoom_in_input.is_empty():
				warnings.append("camera zoom in input is empty")
			if camera_zoom_out_input.is_empty():
				warnings.append("camera zoom out input is empty")
			if camera_pan_input.is_empty():
				warnings.append("camera pan input is empty")
	
	return warnings

func _is_input_map_valid() -> bool:
	for input in [west_input, east_input, north_input, south_input]:
		if input.is_empty():
			return false
	return true