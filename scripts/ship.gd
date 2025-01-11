extends CharacterBody2D

var ACCEL = 2
var MAX_SPEED = 5
var ROTATION_SPEED = 90

@onready var screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	var rotation_dir = Input.get_axis("left", "right")
	
	rotation_degrees += rotation_dir * ROTATION_SPEED * delta
	
	var ship_forward_dir = -transform.y
	
	velocity += ship_forward_dir * Input.get_action_strength("up") * delta * ACCEL
	velocity = velocity.limit_length(MAX_SPEED)
	
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
	
	move_and_collide(velocity)
