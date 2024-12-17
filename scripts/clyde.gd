extends GhostBase

var clyde_scatter = false

func _ready() -> void:
	super()
	allowed_out = false

func make_path() -> void:
	#see how far away player is
	var distance_to_player = global_position.distance_to(player.global_position)
	
	#if too close, start scattering
	if out_of_house and distance_to_player < (Globals.TILE_SIZE * 8):
		clyde_scatter = true
		$ClydeScatterTimer.start()
	
	#If scattering, scatter.
	if out_of_house and clyde_scatter:
		nav_agent.target_position = scatter_path[scatter_index].global_position
	#If out of house, move to player
	elif  out_of_house:
		nav_agent.target_position = player.global_position
	#If in house, move out of house.
	else:
		nav_agent.target_position = out_of_house_marker.global_position

func _on_clyde_scatter_timer_timeout() -> void:
	clyde_scatter = false
