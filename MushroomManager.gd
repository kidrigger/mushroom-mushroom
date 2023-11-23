extends Node3D

var prev_slide_count: int = 0
var slide_count: int = 0

signal begin_slide
signal end_slide

func start_slide_contact():
	print("begin", slide_count)
	slide_count += 1

func end_slide_contact():
	print("end", slide_count)
	slide_count -= 1

func _process(delta):
	if prev_slide_count == 0 and slide_count != 0:
		begin_slide.emit()
	if prev_slide_count != 0 and slide_count == 0:
		end_slide.emit()
	prev_slide_count = slide_count

func _new_mushroom(node):
	
	var scr = node.get_script().get_script_signal_list()
	var found = false
	for ar in scr:
		if ar.name == "begin_slide":
			found = true
			break
	
	if not found:
		return
	
	node.begin_slide.connect(start_slide_contact)
	node.end_slide.connect(end_slide_contact)
		
	pass # Replace with function body.
