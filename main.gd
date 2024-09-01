extends Node2D

@export var unit_count: int = 20
@onready var selection_start: Vector2
@onready var selection_rect: Rect2
@onready var is_mouse_dragging: bool = false
@onready var unit_scene: PackedScene = preload("res://unit.tscn")
@onready var units: Array

func _ready():
	var viewport_rect = get_viewport_rect()
	var margin = 50
	for i in range(unit_count):
		var x = randi_range(viewport_rect.position.x + margin, viewport_rect.position.x + viewport_rect.size.x - margin)
		var y = randi_range(viewport_rect.position.y + margin, viewport_rect.position.y+ viewport_rect.size.y - margin)
		var unit = unit_scene.instantiate()
		unit.position = Vector2(x, y)
		units.push_back(unit)
		add_child(unit)

func _draw():
	if is_mouse_dragging: # if false will clear drawing
		draw_rect(selection_rect, Color.BLUE)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if  event.is_pressed():
				selection_start = event.position
				is_mouse_dragging = true
			if  event.is_released():
				is_mouse_dragging = false
				queue_redraw()
			if event.is_double_click():
				for unit in units:
					unit.deselect()
	elif event is InputEventMouseMotion and is_mouse_dragging:
		var mouse_position = event.position
		var rect_size = mouse_position - selection_start
		selection_rect = Rect2(selection_start, rect_size)
		queue_redraw()
	
		for unit in units:
			if selection_rect.abs().has_point(unit.position):
				unit.select()
			else:
				unit.deselect()
