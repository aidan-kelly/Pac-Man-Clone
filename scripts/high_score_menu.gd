extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Pellets.hide_pellets()
	Globals.load_scores()
	for record in Globals.score_records:
		$MarginContainer/VBoxContainer/HBoxContainer/UserList.add_item(record.name)
		$MarginContainer/VBoxContainer/HBoxContainer/ScoreList.add_item(str(record.high_score))

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
