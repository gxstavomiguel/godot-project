extends Node3D

@export var variavel : int = 1
@onready var decimal: float = 0.0
var boleano: bool = false
var text : String = 'texto'

var vector2 : Vector2 = Vector2.ZERO
var vector3: Vector3 = Vector3.ZERO
var vector4: Vector4 = Vector4.ZERO

var array : Array[String] = ["txt1", "txt2"]

var dicionario : Dictionary = {}

@onready var ball: RigidBody3D = $Ball

func _ready():
	pass
	
func _process(delta):
	var direcao = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direcao.length() > 0:
		ball.apply_impulse(Vector3(direcao.y, 0.0, -direcao.x).normalized() * 0.5)
