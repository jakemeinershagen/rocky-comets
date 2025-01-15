extends Control

@onready var label = $Label


func _process(_delta: float) -> void:
	label.text = "Score: %d" % Shared.score
	label.text += "\nLives: %d" % Shared.lives
