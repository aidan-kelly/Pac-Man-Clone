extends Node

signal stat_change
signal level_passed
signal game_over
signal power_pellet_eaten

const TILE_SIZE = 8
const MAX_VISIBLE_PELLETS = 244
var visible_pellets = MAX_VISIBLE_PELLETS

var score_amount: int = 0:
	set(value):
		if value != score_amount:
			visible_pellets -= 1
			score_amount = value
			stat_change.emit()
			if visible_pellets == 0:
				level_passed.emit()

var scatter: bool = false

var invinsible: bool = false:
	set(value):
		if value != invinsible:
			invinsible = value
			scatter = true
			power_pellet_eaten.emit()

var lives: int = 3:
	set(value):
		if value != lives:
			if value != 0:
				lives = value
				stat_change.emit()
			else:
				game_over.emit()
