extends CharacterBody2D
signal player_hit
@onready var ray = $RayCast2D
@onready var screen_size = get_viewport_rect().size
const SPEED = 50
var direction = Vector2()
var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}

#Processes 11 times per second.
func _physics_process(delta: float) -> void:
	#Screen wrapping.
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
	#are we pressing a direction?
	var dir_vector = Input.get_vector("left", "right", "up", "down")
	
	for dir in inputs.values():
		#pressed direction
		if dir == dir_vector:
			move(dir)
	if(dir_vector != direction):
		move(direction)

func move(dir):
	if dir in inputs.values():
		ray.target_position = dir * (Globals.TILE_SIZE * 2)
		ray.force_raycast_update()
		if !ray.is_colliding():
			position += dir * Globals.TILE_SIZE / 2
			direction = dir

func score(amount_to_add: int) -> void:
	Globals.score_amount += amount_to_add

func hit() -> void:
	Globals.lives -= 1
	player_hit.emit()
