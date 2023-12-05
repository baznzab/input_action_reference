class_name FreeCamera
extends Camera3D


@export var move_speed: float = 2.5
@export var turbo_multiplier: float = 2.5
@export var look_speed: float = 10
@export var action_move_left: InputActionReference
@export var action_move_right: InputActionReference
@export var action_move_forward: InputActionReference
@export var action_move_back: InputActionReference
@export var action_turbo: InputActionReference

var _mouse_moved: bool
var _mouse_delta: Vector2

var _yaw: float:
	get: return _yaw
	set(value): _yaw = wrapf(value, -360, 360)

var _pitch: float:
	get: return _pitch
	set(value): _pitch = clampf(wrapf(value, -360, 360), -90, 90)


func _ready() -> void:
	var euler := quaternion.get_euler()
	_yaw = rad_to_deg(euler.y)
	_pitch = rad_to_deg(euler.x)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_mouse_delta = event.relative
		_mouse_moved = true


func _process(delta: float) -> void:
	if not _mouse_moved:
		_mouse_delta = Vector2.ZERO
	_mouse_moved = false

	# rotate
	var look := look_speed * _mouse_delta * delta
	_yaw -= look.x
	_pitch -= look.y

	var yaw_rotation := Quaternion(Vector3.UP, deg_to_rad(_yaw)).normalized()
	var pitch_rotation := Quaternion(Vector3.RIGHT, deg_to_rad(_pitch)).normalized()
	var result_rotation := (yaw_rotation * pitch_rotation).normalized()
	quaternion = result_rotation

	# move
	var move_input := Input.get_vector(
		action_move_left.value, action_move_right.value,
		action_move_back.value, action_move_forward.value)
	var move_direction := (
		move_input.x * global_transform.basis.x -
		move_input.y * global_transform.basis.z
	).normalized()
	var move_velocity := move_speed * move_direction
	if Input.is_action_pressed(action_turbo.value):
		move_velocity *= turbo_multiplier
	global_position += move_velocity * delta
