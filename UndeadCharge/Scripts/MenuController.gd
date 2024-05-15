class_name Options
extends Control

func _on_play_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Game/Game.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

func _on_resume_button_pressed():
	get_tree().paused = false
	hide()

func ToggleMenu(toggle):
	if toggle:
		show()
	else:
		hide()
