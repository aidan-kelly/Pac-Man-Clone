extends Node2D
var lives_image_scene: PackedScene = preload("res://scenes/lives_image.tscn")

func _ready() -> void:
	Globals.stat_change.connect(on_stat_change)
	Globals.game_over.connect(on_game_over)
	Globals.level_passed.connect(on_level_passed)
	on_stat_change()
	$Player.player_hit.connect(on_player_hit)
	for i in Globals.lives:
		var life = lives_image_scene.instantiate()
		$UI/LivesContainer.add_child(life)

func on_stat_change():
	$UI/ScoreLabel.text = str(Globals.score_amount)
	if Globals.lives < $UI/LivesContainer.get_child_count() and Globals.lives != 0:
		$UI/LivesContainer.remove_child($UI/LivesContainer.get_child(0))

func on_player_hit():
	Globals.scatter = false
	if Globals.lives == 0:
		print("Game over")
	if get_tree():
		get_tree().reload_current_scene()

func _on_scatter_timer_timeout() -> void:
	if Globals.scatter:
		$ScatterTimer.wait_time = 20
	else:
		$ScatterTimer.wait_time = 7
	$ScatterTimer.start()
	Globals.scatter = !Globals.scatter

func on_game_over():
	print("Game over.")
	pass

func on_level_passed():
	print("Level passed.")
	if get_tree():
		get_tree().reload_current_scene()
	Pellets.reset_game()
	
