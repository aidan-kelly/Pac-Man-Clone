extends Node

signal stat_change

const TILE_SIZE = 8

var score_amount: int = 0:
	set(value):
		if value != score_amount:
			score_amount = value
			stat_change.emit()
