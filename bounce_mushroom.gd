extends Node3D

@export
var boost_speed: float
var shroom_normal: Vector3

@onready var mushroom_model = $"mushroom-1"
@onready var pop_audio_stream_player_3d = $"pop-AudioStreamPlayer3D"
@onready var boing_audio_stream_player_3d_2 = $"boing-AudioStreamPlayer3D2"

func _ready():
	mushroom_model.get_node("AnimationPlayer").play("spawn", -1, 4, false)
	pop_audio_stream_player_3d.play()

func initialize(position: Vector3, surface_normal: Vector3, player_position: Vector3):
	var normal = surface_normal.normalized()
	var player_dir = player_position - position
	var forward = (player_dir - normal * normal.dot(player_dir)).normalized()
	
	shroom_normal = normal
	
	look_at_from_position(position, position + forward, normal)
	

var possible_body_found = false
var possible_body_velocity: Vector3

func _on_body_entered(body: Node):
	
	if body is CharacterBody3D:
		if possible_body_found:
			body.velocity = possible_body_velocity - shroom_normal * shroom_normal.dot(possible_body_velocity) + boost_speed * shroom_normal
			possible_body_found = false
			boing_audio_stream_player_3d_2.set_pitch_scale(randf_range(0.85, 1.25))

			boing_audio_stream_player_3d_2.play()
		else:
			body.velocity = body.velocity - 2 * shroom_normal * shroom_normal.dot(body.velocity)

func _on_area_entered(area):
	var possible_body = area.get_parent()
	if possible_body is CharacterBody3D:
		possible_body_found = true
		possible_body_velocity = possible_body.velocity
	
