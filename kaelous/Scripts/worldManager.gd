extends Node3D

const ROTATIONSPEED = 6.28 / (2.5*60.0)
@onready var playerCamera = $Planeta/Nave/Player/Head/Camera3D
@onready var shipCamera = $Planeta/Nave/CameraShip
@onready var windowCamera = $Planeta/Nave/CameraWindow

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("camera_state", Callable(self, "_camera_handler"))
#	$Planeta/Nave/Camera3D.current = true

func _camera_handler() -> void:
	if Global.camera == 0:
		playerCamera.make_current()
	elif Global.camera == 1:
		shipCamera.make_current()
	elif Global.camera == 2:
		windowCamera.make_current()
			


func _process(delta: float) -> void:
	#print($Planeta.rotation_degrees)
	$Planeta.rotate_y(delta * ROTATIONSPEED)
