extends Node3D

const ROTATIONSPEED = 6.28 / (2.5*60.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	$Planeta/Nave/Camera3D.current = true


func _process(delta: float) -> void:
	print($Planeta.rotation_degrees)
	$Planeta.rotate_y(delta * ROTATIONSPEED)
