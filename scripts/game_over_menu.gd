extends Control

func _ready() -> void:
	Pellets.hide_pellets()
	$MarginContainer/VBoxContainer/ScoreLabel.text = str(Globals.score_amount) + " points!"

func _on_play_button_pressed() -> void:
	save_score()
	Pellets.reset_game()
	Globals.reset_game()
	get_tree().change_scene_to_file("res://scenes/level.tscn")

func _on_main_menu_button_pressed() -> void:
	save_score()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_exit_game_button_pressed() -> void:
	save_score()
	get_tree().quit()

func save_score() -> void:
	var record = {
	"name" : $MarginContainer/VBoxContainer/LineEdit.text,
	"high_score" : Globals.score_amount
	}
	print(record)
	Globals.score_records.push_back(record)
	Globals.save_scores()
