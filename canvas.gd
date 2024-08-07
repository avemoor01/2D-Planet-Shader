@tool
extends Node2D
var angle = 0
var increase = 0.01
var materials

# Called when the node enters the scene tree for the first time.
func _ready():
	materials = self.material

func _physics_process(delta):
	angle += increase
	materials.set_shader_parameter("angle", angle)

func _draw():
	draw_rect(Rect2(Vector2(0, 0), Vector2(640, 360)), Color.WHITE)

