extends Node

signal stat_change
signal level_passed
signal game_over
signal power_pellet_eaten
signal scatter_change

const TILE_SIZE = 8
const MAX_VISIBLE_PELLETS = 244
var visible_pellets = MAX_VISIBLE_PELLETS

func _init() -> void:
	load_scores()

var score_amount: int = 0:
	set(value):
		if value != score_amount:
			print("Score = " + str(value) + " Visible pellets = " + str(visible_pellets))
			if(value-score_amount == 10 || value-score_amount == 50):
				visible_pellets -= 1
			score_amount = value
			stat_change.emit()
			if visible_pellets == 0:
				level_passed.emit()

var scatter: bool = false:
	set(value):
		scatter = value
		scatter_change.emit()

var processing_hit: bool = true

var invincible: bool = false:
	set(value):
		if value == true:
			scatter = true
			power_pellet_eaten.emit()
		invincible = value

var lives: int = 3:
	set(value):
		if value != lives:
			if value != 0:
				lives = value
				stat_change.emit()
			else:
				game_over.emit()

var score_records: Array = []

func save_scores() -> void:
	var file = FileAccess.open("user://game.dat", FileAccess.WRITE)
	file.store_var(score_records, true)
	file.close()

func load_scores() -> void:
	var file = FileAccess.open("user://game.dat", FileAccess.READ)
	if file:
		score_records = file.get_var(true)
		score_records.sort_custom(my_sort)
	else:
		print("error loading scores")
		
func reset_game() -> void:
	score_amount = 0
	lives = 3
	scatter = false
	invincible = false

func my_sort(a: Dictionary, b: Dictionary):
	if a["high_score"] > b["high_score"]:
		return true
	else:
		return false
