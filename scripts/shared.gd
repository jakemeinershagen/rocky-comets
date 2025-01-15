extends Node

var lives = 3
var score = 0
var win = null


func _process(_delta: float) -> void:
	if lives < 1:
		win = false


func reset():
	lives = 3
	score = 0
	win = null
	get_tree().paused = false
