extends GhostBase

func _ready() -> void:
	super()
	allowed_out = false

func make_path() -> void:
	if out_of_house:
		#Set target to be 4 tiles in front of the player. 
		var new_target = (player.direction * (4.0 * Globals.TILE_SIZE)) + player.global_position
		nav_agent.target_position = new_target
	else:
		nav_agent.target_position = out_of_house_marker.global_position
