class_name InputActionReferenceInspectorPlugin
extends EditorInspectorPlugin


func _can_handle(object: Object) -> bool:
	for property in object.get_property_list():
		if(property["hint"] == PROPERTY_HINT_RESOURCE_TYPE and
			property["hint_string"] == "InputActionReference"):
			return true
	return false


func _parse_property(object: Object, type: Variant.Type,
	name: String, hint: PropertyHint, hint_string: String,
	usage_flags: int, wide: bool) -> bool:
	if(hint == PROPERTY_HINT_RESOURCE_TYPE and
		hint_string == "InputActionReference"):
		add_property_editor(name, InputActionReferenceEditorProperty.new())
		return true
	return false
