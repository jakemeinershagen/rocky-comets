extends Control


func _process(_delta: float) -> void:
	if Shared.win == true:
		show_win()
	elif Shared.win == false:
		show_loss()


func show_win():
	$ResultLabel.text = "You Win!"
	visible = true
	get_tree().paused = true


func show_loss():
	$ResultLabel.text = "You Lose :("
	visible = true
	get_tree().paused = true


func _on_reset_button_button_up() -> void:
	get_tree().reload_current_scene()
	visible = false
	Shared.reset()
