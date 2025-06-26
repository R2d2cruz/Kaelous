extends CharacterBody3D


const SPEED = 5.0
const ANGLESPEED = 5
const ANGLEROTATION = 20.0
var in_conduction = false

func _ready():
	Global.connect("camera_state", Callable(self, "_active_ship"))

func _active_ship():
	in_conduction = Global.camera == 1

func _on_wheel_body_entered(body: Node3D):
	if body.is_in_group("Players"):
		Global.body_in_ship(body, 1)

func _on_wheel_body_exited(body: Node3D):
	if body.is_in_group("Players"):
		Global.body_out_ship(body)

func _physics_process(delta: float) -> void:
	if in_conduction:
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir := Input.get_vector("left", "right", "up", "down").normalized()
		print(input_dir)
		if input_dir:
			velocity.y = input_dir.x * SPEED
			velocity.x = input_dir.y * SPEED
			rotation_degrees.x = move_toward(rotation_degrees.x, input_dir.x * ANGLEROTATION, ANGLESPEED)
			rotation_degrees.y = move_toward(rotation_degrees.x, input_dir.y * ANGLEROTATION, ANGLESPEED)
		else:
			rotation_degrees.x = move_toward(rotation_degrees.x, 0, ANGLESPEED)
			rotation_degrees.y = move_toward(rotation_degrees.x, 0, ANGLESPEED)
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
