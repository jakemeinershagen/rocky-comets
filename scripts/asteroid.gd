extends CharacterBody2D

var speed = 100

@onready var screen_size = get_viewport_rect().size

func _ready() -> void:
	velocity = Vector2(
		randf(),
		randf()
	) * speed


func _physics_process(_delta: float) -> void:
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
	
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Bullet:
		body.queue_free()
		queue_free()
		if scale.x > .26:
			get_parent().spawn_split(position, scale * .5, speed + 20)
