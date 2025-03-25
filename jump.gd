extends MeshInstance3D


func _on_area_3d_body_entered(body):
	if(body as Node3D).is_in_group("player"):
		(body as CharacterBody3D).velocity.y += 20
