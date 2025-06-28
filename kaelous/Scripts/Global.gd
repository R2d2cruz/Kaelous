extends Node

var camera = 0  # =: Jugador, 1: Nave, 2: ventana, 3: robot
signal camera_state
signal go_around
var player_in_module = 0

var min_r_limit := 50.0
var max_r_limit := 1500.0

func ship_out_of_limits(current_r):
	print("Game Over: nave fuera del límite. r =", current_r)
	# Aquí puedes pausar el juego, mostrar UI, cambiar de escena, etc.


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
	
func body_in_ship(body: Node3D, accion: int):
	player_in_module = accion
	
func body_out_ship(body: Node3D):
	player_in_module = 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("accion"):
		if player_in_module == 1:
			if camera == 0:
				camera = 1
			else:
				camera = 0 
		emit_signal("camera_state")
	if event.is_action_pressed("r"):
		emit_signal("go_around")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
