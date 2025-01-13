extends Node2D

@export var asteroid_scn: PackedScene

@onready var screen_size = get_viewport_rect().size

func _ready() -> void:
	for i in range(0, 3):
		var pos = Vector2(
			randi_range(0, screen_size.x),
			randi_range(0, screen_size.y)
		)
		spawn_asteroid(pos)


func spawn_split(position, scale, speed):
	spawn_asteroid(position - Vector2.ONE * 20, scale, speed)
	spawn_asteroid(position + Vector2.ONE * 20, scale, speed)


func spawn_asteroid(position, scale = Vector2(1, 1), speed = 10):
	var new_ast = asteroid_scn.instantiate()
	new_ast.position = position
	new_ast.scale = scale
	new_ast.speed = speed
	add_child(new_ast)
