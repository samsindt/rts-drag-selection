extends Node2D

@export var radius: float = 20.0
@onready var is_selected: bool = false
@onready var hexigon: Polygon2D = $Polygon2D

func _ready():
	var points = PackedVector2Array()
	for i in range(6):
		var point = deg_to_rad(i * 360.0 / 6 - 90)
		points.push_back(Vector2.ZERO + Vector2(cos(point), sin(point)) * radius)
		
	hexigon.polygon = points
	hexigon.color = Color.RED
	
func select():
	if !is_selected:
		hexigon.color = Color.GREEN
		is_selected = true

func deselect():
	if is_selected:
		hexigon.color = Color.RED
		is_selected = false
