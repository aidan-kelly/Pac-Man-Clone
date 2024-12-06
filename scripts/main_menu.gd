extends Control

func _ready() -> void:
	Pellets.hide_pellets()

func _on_play_button_pressed() -> void:
	Pellets.reset_game()
	Globals.reset_game()
	get_tree().change_scene_to_file("res://scenes/level.tscn")

func _on_high_scores_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/high_score_menu.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
