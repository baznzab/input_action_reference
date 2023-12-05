class_name InputActionPicker
extends ConfirmationDialog


signal on_action_selected(action: StringName)


var _item_list: ItemList
var _options: Array[StringName]


func _init() -> void:
	_item_list = ItemList.new()
	_item_list.item_activated.connect(_item_activated)
	add_child(_item_list)
	confirmed.connect(_confirmed)


func _confirmed() -> void:
	if not _item_list.is_anything_selected():
		return
	on_action_selected.emit(_options[_item_list.get_selected_items()[0]])


func _item_activated(index: int) -> void:
	hide()
	on_action_selected.emit(_options[index])


func popup_dialog() -> void:
	_options = _load_input_actions()
	_item_list.clear()
	for option in _options:
		_item_list.add_item(option)

	var editor_scale := EditorInterface.get_editor_scale()
	popup_centered_clamped(editor_scale * Vector2i(600, 440))


func _load_input_actions() -> Array[StringName]:
	var result := [] as Array[StringName]
	for property in ProjectSettings.get_property_list():
		var property_name := property["name"] as String
		if not property_name.begins_with("input/"):
			continue
		var action_name := property_name.substr(
			property_name.find("/") + 1, property_name.length())
		result.append(action_name)
	return result
