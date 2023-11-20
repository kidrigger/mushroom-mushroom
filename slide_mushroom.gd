extends Node3D

@export
var boost_factor: float
var shroom_normal: Vector3

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
			var planar = possible_body_velocity - shroom_normal * shroom_normal.dot(possible_body_velocity);
			body.velocity = planar * boost_factor
			possible_body_found = false
		else:
			body.velocity = body.velocity - 2 * shroom_normal * shroom_normal.dot(body.velocity)

func _on_area_entered(area):
	var possible_body = area.get_parent()
	if possible_body is CharacterBody3D:
		possible_body_found = true
		possible_body_velocity = possible_body.velocity
	
