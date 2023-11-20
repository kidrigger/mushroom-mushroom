extends Node3D

@export
var pixel_to_degree: float = 10.0

var deg_pitch: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if event is InputEventMouseMotion:
		var deg_prev_pitch = deg_pitch
		deg_pitch -= event.relative.y  / pixel_to_degree
		deg_pitch = clampf(deg_pitch, -89.0, 89.0)
		var delta_pitch = deg_pitch - deg_prev_pitch
		transform = transform.rotated_local(Vector3.RIGHT, deg_to_rad(delta_pitch))
