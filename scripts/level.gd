extends Node2D

func _ready() -> void:
	Globals.stat_change.connect(on_stat_change)
	on_stat_change()
	$Player.player_hit.connect(on_player_hit)

func on_stat_change():
	$ScoreLabel.text = str(Globals.score_amount)

func on_player_hit():
	if get_tree():
		get_tree().reload_current_scene()

func _on_scatter_timer_timeout() -> void:
	if Globals.scatter:
		$ScatterTimer.wait_time = 20
	else:
		$ScatterTimer.wait_time = 7
	$ScatterTimer.start()
	Globals.scatter = !Globals.scatter
