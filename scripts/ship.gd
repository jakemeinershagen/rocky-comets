extends CharacterBody2D

@export var bullet_scene: PackedScene
@export var shot_sound: AudioStreamPlayer2D

var ACCEL = 40
var MAX_SPEED = 100
var ROTATION_SPEED = 90

@onready var screen_size = get_viewport_rect().size
@onready var shot_cooldown = $ShotCooldown
@onready var bullet_spawn_point = $BulletSpawnPoint
@onready var starting_pos = position

func _process(_delta: float) -> void:
	if Input.is_action_pressed("fire") and shot_cooldown.is_stopped():
		fire_bullet()

func _physics_process(delta: float) -> void:
	var rotation_dir = Input.get_axis("left", "right")
	
	rotation_degrees += rotation_dir * ROTATION_SPEED * delta
	
	var ship_forward_dir = -transform.y
	
	velocity += ship_forward_dir * Input.get_action_strength("up") * delta * ACCEL
	velocity = velocity.limit_length(MAX_SPEED)
	
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
	
	if Input.is_action_pressed("down"):
		velocity -= velocity.normalized() * ACCEL * delta
	
	var collision = move_and_collide(velocity * delta)

	if collision:
		var coll_body = collision.get_collider()
		if coll_body is Bullet:
			coll_body.queue_free()
			die()
		elif coll_body is Asteroid:
			die()


func fire_bullet():
	var new_bullet = bullet_scene.instantiate()
	new_bullet.position = bullet_spawn_point.global_position
	new_bullet.direction = -transform.y
	get_parent().add_child(new_bullet)
	shot_cooldown.start()
	shot_sound.play()


func die():
	position = starting_pos
	velocity = Vector2.ZERO
	rotation = 0
	Shared.lives -= 1
	$ExplosionSound.play()
