extends CharacterBody2D

@export var bullet_scene: PackedScene

var ACCEL = 40
var MAX_SPEED = 100
var ROTATION_SPEED = 90

@onready var screen_size = get_viewport_rect().size

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("fire"):
		fire_bullet()

func _physics_process(delta: float) -> void:
	var rotation_dir = Input.get_axis("left", "right")
	
	rotation_degrees += rotation_dir * ROTATION_SPEED * delta
	
	var ship_forward_dir = -transform.y
	
	velocity += ship_forward_dir * Input.get_action_strength("up") * delta * ACCEL
	velocity = velocity.limit_length(MAX_SPEED)
	
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
	
	move_and_collide(velocity * delta)


func fire_bullet():
	var new_bullet = bullet_scene.instantiate()
	new_bullet.position = position
	new_bullet.direction = -transform.y
	get_parent().add_child(new_bullet)
