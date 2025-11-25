@tool
extends EditorPlugin


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	#Add Custom Types
	add_custom_type(
		"AceInputMap",
		"Node",
		preload("res://addons/anomalyAcesInputMap/AceInputMap/ace_input_map.gd"),
		preload("res://addons/anomalyAcesInputMap/AceInputMap/AceInputMap.svg")
	)

	AceLog.printLog(["AceInputMap Entering Tree"])


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	remove_custom_type("AceInputMap")
