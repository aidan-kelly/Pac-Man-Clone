extends GhostBase

@export var blinky : Node2D

func _ready() -> void:
	super()
	allowed_out = false

func make_path() -> void:
	if out_of_house:
		#Take vector from Blinky to Player's pos + 2 tiles.
		var blinky_target = blinky.global_position
		var player_target = (player.direction * (2 * Globals.TILE_SIZE)) + player.global_position
		var connecting_vector = ((player_target - blinky_target)) + player_target
		#Double that vector
		nav_agent.target_position = connecting_vector
	else:
		nav_agent.target_position = out_of_house_marker.global_position
