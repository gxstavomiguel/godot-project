extends Node3D

var ballClass = preload("res://Ball.tscn")

func _on_spawn_timer_timeout() -> void:
	var point = get_tree().get_nodes_in_group("spawn").pick_random() as Node3D
	var ball = ballClass.instantiate() as RigidBody3D
	add_child(ball)
	ball.global_position = point.global_position
