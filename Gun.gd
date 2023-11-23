extends Node3D

@onready
var n_camera = get_node("../CameraYaw/CameraPitch") as Node3D

@export
var scn_bounce_mushroom: PackedScene
@export
var scn_slide_mushroom: PackedScene

@onready
var n_level = get_tree().root.get_node("Prototype World/MushroomManager")
	
func _physics_process(delta):
	
	var shoot = Input.is_action_just_pressed("act_shoot")
	var alt_shoot = Input.is_action_just_pressed("act_alt_shoot")
	if shoot or alt_shoot:
		var space_state = get_world_3d().direct_space_state
		var cam = n_camera

		var origin = cam.global_position
		var end = origin + cam.global_transform.basis * Vector3.FORWARD * 20.0
		var query = PhysicsRayQueryParameters3D.create(origin, end)
		query.collide_with_areas = true

		var result = space_state.intersect_ray(query)
		if not result.is_empty():
			var mush: Node
			if shoot:
				mush = scn_bounce_mushroom.instantiate()
			elif alt_shoot:
				mush = scn_slide_mushroom.instantiate()
			mush.initialize(result.position, result.normal, global_position)
			n_level.add_child(mush)
		
