class_name InputActionReferenceEditorProperty
extends EditorProperty


var _button: Button
var _current_value: StringName


func _init() -> void:
	_button = Button.new()
	_button.alignment = HORIZONTAL_ALIGNMENT_LEFT
	_button.text_overrun_behavior = TextServer.OVERRUN_TRIM_CHAR
	_button.pressed.connect(_on_button_pressed)
	add_child(_button)
	_refresh_button_text()


func _on_button_pressed() -> void:
	var pick_dialog := InputActionPicker.new()
	pick_dialog.on_action_selected.connect(_on_action_selected)
	add_child(pick_dialog)
	pick_dialog.popup_dialog()


func _on_action_selected(action: StringName) -> void:
	_current_value = action
	_refresh_button_text()
	var action_ref := get_edited_object()[get_edited_property()] as InputActionReference
	if not is_instance_valid(action_ref):
		action_ref = InputActionReference.new()
	action_ref.value = _current_value
	emit_changed(get_edited_property(), action_ref)


func _update_property() -> void:
	var new_action_ref := get_edited_object()[get_edited_property()] as InputActionReference
	var new_value := "" as StringName
	if is_instance_valid(new_action_ref):
		new_value = new_action_ref.value
	if new_value == _current_value:
		return
	_current_value = new_value
	_refresh_button_text()


func _refresh_button_text() -> void:
	_button.text = _current_value
