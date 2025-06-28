extends CharacterBody3D

var ANGLEROTATION = 30
var ANGLESPEED = 5

var velocityAux = Vector3.ZERO
var maxSpeed = 10.0
var deltaSpeed = 5.0

var in_conduction := false

var initial_r := 0.0
var initial_theta := 0.0
var returning_to_orbit := false
var orbit_initialized := false

func _ready():
	Global.connect("camera_state", Callable(self, "_active_ship"))
	Global.connect("go_around", Callable(self, "_go_around"))
	call_deferred("_init_orbit_data")

func _init_orbit_data():
	initial_r = _radius()
	initial_theta = _angle()
	orbit_initialized = true

func _radius() -> float:
	return round(sqrt((position.x**2) + (position.y**2) + (position.z**2)))
	
func _angle() -> float:
	return round(atan2(position.y, -position.x))

func _active_ship():
	in_conduction = Global.camera == 1
	
func _go_around():
	in_conduction = false
	returning_to_orbit = true

func _on_wheel_body_entered(body: Node3D):
	if body.is_in_group("Players"):
		Global.body_in_ship(body, 1)

func _on_wheel_body_exited(body: Node3D):
	if body.is_in_group("Players"):
		Global.body_out_ship(body)

func _process(delta: float) -> void:
	if not orbit_initialized:
		return

	var input_dir = Input.get_vector("right", "left" ,"down", "up").normalized()
	
	if in_conduction and not returning_to_orbit:
		var target = input_dir * maxSpeed
		velocityAux.x = move_toward(velocityAux.x, target.x, deltaSpeed * delta)
		velocityAux.y = move_toward(velocityAux.y, target.y, deltaSpeed * delta)
		print(input_dir, target)
		# Visual tilt
		rotation_degrees.x = move_toward(rotation_degrees.x, input_dir.x * ANGLEROTATION, ANGLESPEED * delta)
		rotation_degrees.y = move_toward(rotation_degrees.y, input_dir.y * ANGLEROTATION, ANGLESPEED * delta)
	elif not in_conduction and not returning_to_orbit:
		rotation_degrees.x = move_toward(rotation_degrees.x, 0.0, ANGLESPEED * delta)
		rotation_degrees.y = move_toward(rotation_degrees.y, 0.0, ANGLESPEED * delta)
		velocityAux.x = move_toward(velocityAux.x, 0, deltaSpeed * delta)
		velocityAux.y = move_toward(velocityAux.y, 0, deltaSpeed * delta)
		velocityAux.z = move_toward(velocityAux.z, 0, deltaSpeed * delta)
	elif returning_to_orbit:
		var delta_x = -(position.x + initial_r * cos(initial_theta))
		var delta_y = initial_r * sin(initial_theta) - position.y
		var delta_p = Vector2(delta_x, delta_y)
		var targetV = delta_p / maxSpeed
		var targetB = delta_p.normalized()
		var target = targetB if targetB.length() < targetV.length() else targetV
		velocityAux.x = move_toward(velocityAux.x, target.x * maxSpeed, deltaSpeed * delta)
		velocityAux.y = move_toward(velocityAux.y, target.y * maxSpeed, deltaSpeed * delta)
		print(position.x + initial_r * cos(initial_theta), "\t", initial_r * sin(initial_theta), "\t" , initial_r * cos(initial_theta), "\t", target)
		# Visual tilt
		rotation_degrees.x = move_toward(rotation_degrees.x, -target.x * ANGLEROTATION, ANGLESPEED * delta)
		rotation_degrees.y = move_toward(rotation_degrees.y, target.y * ANGLEROTATION, ANGLESPEED * delta)
		if abs(delta_x) < 0.1 and abs(delta_y) < 0.1:
			returning_to_orbit = false
			_active_ship()
	
	position += velocityAux * delta
