extends Node3D

@export
var pixel_to_degree: float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if event is InputEventMouseMotion:
		var deg_yaw = -event.relative.x / pixel_to_degree
		transform = transform.rotated_local(Vector3.UP, deg_to_rad(deg_yaw))
