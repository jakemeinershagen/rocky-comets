extends CharacterBody2D

var SPEED = 200
var direction = Vector2.RIGHT

@onready var screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	velocity = SPEED * direction * delta

	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)

	move_and_collide(velocity)
