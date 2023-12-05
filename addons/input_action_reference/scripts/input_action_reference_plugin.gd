@tool
class_name InputActionReferencePlugin
extends EditorPlugin


var _input_action_reference_inspector_plugin: InputActionReferenceInspectorPlugin


func _enter_tree() -> void:
	_input_action_reference_inspector_plugin = InputActionReferenceInspectorPlugin.new()
	add_inspector_plugin(_input_action_reference_inspector_plugin)


func _exit_tree() -> void:
	remove_inspector_plugin(_input_action_reference_inspector_plugin)
