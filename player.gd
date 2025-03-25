extends CharacterBody3D

var SPEED = 6.0
const JUMP_VELOCITY = 6.5
const MOUSE_SENSITIVITY = 0.1
const TURN_SPEED = 10

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") * 2.0
@onready var pivot = $Pivot
@onready var camera = $Pivot/Camera3D
@onready var geometry = $Geometry

func _input(event):
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif Input.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		#pivot.rotate_y(-(event as InputEventMouseMotion).relative.x * MOUSE_SENSITIVITY)
		#camera.rotate_x(-(event as InputEventMouseMotion).relative.y * MOUSE_SENSITIVITY)
		#camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-80), deg_to_rad(80))
		rotate_y(deg_to_rad(-(event as InputEventMouseMotion).relative.x * MOUSE_SENSITIVITY))
		geometry.rotate_y(deg_to_rad((event as InputEventMouseMotion).relative.x * MOUSE_SENSITIVITY))
		pivot.rotate_x(deg_to_rad(-(event as InputEventMouseMotion).relative.y * MOUSE_SENSITIVITY))
		pivot.rotation.x = deg_to_rad(clamp(rad_to_deg(pivot.rotation.x), -90, 90))
		
		
func _physics_process(delta):
	if not is_on_floor():
		velocity.y -=  gravity * delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
			
	if Input.is_action_pressed("run") and is_on_floor():
		SPEED = 8.5
	else:
		SPEED = 6.5
		
	var input_dir = Input.get_vector("left", "down", "forward" , "right", )
	#var direction = (pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		var prev_y = geometry.rotation.y
		#geometry.look_at(Vector3(position.x, position.y, position.z), Vector3.UP)
		geometry.look_at(Vector3(position.x, position.y, position.z) + direction)
		var target_y = geometry.rotation.y
		geometry.rotation.y = lerp_angle(prev_y, target_y, delta * TURN_SPEED)
	else:
		velocity.x = move_toward(direction.x, 0, SPEED)
		velocity.z = move_toward(direction.z, 0, SPEED)
		
		
		
	move_and_slide()
