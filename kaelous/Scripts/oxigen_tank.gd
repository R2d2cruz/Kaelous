extends Node3D

var red = preload("res://Assets/Materials/oxigen_tank_red.tres")
var blue = preload("res://Assets/Materials/oxigen_tank_blue.tres")

@onready var ordered_sections = [
	$Tank0/Section0,
	$Tank0/Section1,
	$Tank0/Section2,
	$Tank0/Section3,

	$Tank1/Section0,
	$Tank1/Section1,
	$Tank1/Section2,
	$Tank1/Section3,

	$Tank2/Section0,
	$Tank2/Section1,
	$Tank2/Section2,
	$Tank2/Section3,
]

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	var total = ordered_sections.size()
	var blue_count = round((Global.oxigen / 100.0) * total)

	for i in range(total):
		var section = ordered_sections[i]
		if i > blue_count:
			section.set_surface_override_material(0, blue)
		else:
			section.set_surface_override_material(0, red)
