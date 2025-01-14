extends Node2D

@export var asteroid_scn: PackedScene
@export var player: CharacterBody2D

var num_asteroids_to_spawn = 3

@onready var screen_size = get_viewport_rect().size


func _ready() -> void:
	spawn_num_asteroids(num_asteroids_to_spawn)


func _process(_delta: float) -> void:
	if get_child_count() == 0:
		num_asteroids_to_spawn += 2
		spawn_num_asteroids(num_asteroids_to_spawn)


func spawn_num_asteroids(num):
	for i in range(0, num):
		var pos = Vector2.ZERO
		var diff = Vector2.ZERO
		while diff.length() < 75:
			pos = Vector2(
				randi_range(0, screen_size.x),
				randi_range(0, screen_size.y)
			)
			diff = pos - player.position
		spawn_asteroid(pos)


func spawn_split(pos, scaling, speed):
	spawn_asteroid(pos - Vector2.ONE * 20, scaling, speed)
	spawn_asteroid(pos + Vector2.ONE * 20, scaling, speed)


func spawn_asteroid(pos, scaling = Vector2(1, 1), speed = 10):
	var new_ast = asteroid_scn.instantiate()
	new_ast.position = pos
	new_ast.scale = scaling
	new_ast.speed = speed
	self.call_deferred("add_child", new_ast)
