extends Node2D
var lives_image_scene: PackedScene = preload("res://scenes/lives_image.tscn")

func _ready() -> void:
	Globals.stat_change.connect(on_stat_change)
	Globals.game_over.connect(on_game_over)
	Globals.level_passed.connect(on_level_passed)
	Globals.power_pellet_eaten.connect(on_power_pellet_eaten)
	Globals.processing_hit = false
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
	if !Globals.processing_hit:
		Globals.processing_hit = true
		Globals.scatter = false
		Globals.lives -= 1
		if Globals.lives > 0 and get_tree():
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
	get_tree().change_scene_to_file("res://scenes/game_over_menu.tscn")

func on_level_passed():
	print("Level passed.")
	if get_tree():
		get_tree().reload_current_scene()
	Pellets.reset_game()

func on_power_pellet_eaten():
	$ScatterTimer.stop()
	$PowerPelletTimer.start()

func _on_power_pellet_timer_timeout() -> void:
	$ScatterTimer.wait_time = 20
	$ScatterTimer.start()
	Globals.scatter = false
	Globals.invinsible = false
