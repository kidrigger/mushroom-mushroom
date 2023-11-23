extends CharacterBody3D


@export
var SPEED = 5.0

@export
var JUMP_VELOCITY = 4.5

@onready
var n_camera_yaw = get_node("CameraYaw") as Node3D;

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var sliding = false

func enable_slide():
	sliding = true

func disable_slide():
	sliding = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("mv_left", "mv_right", "mv_fwd", "mv_back")
	var direction = (n_camera_yaw.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if not Input.is_action_pressed("mv_precision"):
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		elif is_on_floor() and not sliding:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
	else:
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()

