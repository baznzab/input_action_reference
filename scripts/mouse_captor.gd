class_name MouseCaptor
extends Node


func _input(event: InputEvent) -> void:
	if event.is_action("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
