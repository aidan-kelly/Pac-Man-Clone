extends Node2D

func reset_game():
	var children = get_children()
	for child in children:
		child.visible = true
	Globals.visible_pellets = Globals.MAX_VISIBLE_PELLETS

func hide_pellets():
	var children = get_children()
	for child in children:
		child.visible = false
	Globals.visible_pellets = 0
