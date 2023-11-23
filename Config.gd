extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass # Replace with function body.


func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		var scene_tree = get_tree()
		scene_tree.root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
		scene_tree.quit()

