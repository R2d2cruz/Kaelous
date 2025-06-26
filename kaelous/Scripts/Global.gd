extends Node

var camera = 0  # =: Jugador, 1: Nave, 2: ventana, 3: robot
signal camera_state

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("accion"):
		camera += 1
		if camera > 2:
			camera = 0
		emit_signal("camera_state")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
