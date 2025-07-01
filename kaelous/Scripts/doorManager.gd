extends CharacterBody3D

var openSpeed = 2
var doorUp
var doorDown
var doorUpCollision
var doorDownCollision
var open
var move

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	doorUp = $DoorMeshUp
	doorDown = $DoorMeshDown
	doorUpCollision = $DoorCollisionUp
	doorDownCollision = $DoorCollisionDown
	open = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if open:
		move = Vector3(0, move_toward(doorUp.position.y, 5, openSpeed * delta), 0)
		doorUp.position = move
		doorDown.position = -move
		doorDownCollision.position = -move
		doorUpCollision.position = move
		if doorUp.position.y >= 5:
			doorUp.visible = false
			doorDown.visible = false
	else:
		move = Vector3(0, move_toward(doorUp.position.y, 0, openSpeed * delta), 0)
		doorUp.position = move
		doorDown.position = -move
		doorDownCollision.position = -move
		doorUpCollision.position = move
		


func _on_door_opener_body_entered(body: Node3D) -> void:
	if body.is_in_group("Players"):
		open = true
		print("enter")


func _on_door_opener_body_exited(body: Node3D) -> void:
	if body.is_in_group("Players"):
		open = false
		doorUp.visible = true
		doorDown.visible = true
