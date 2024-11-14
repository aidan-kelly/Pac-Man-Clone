extends CharacterBody2D
class_name GhostBase

const speed = 50
var scatter_index = 0
@export var player: Node2D
@export var out_of_house_marker: Node2D
@export var scatter_path_parent: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var scatter_path := scatter_path_parent.get_children()

var out_of_house = false
var allowed_out = true

func _physics_process(delta: float) -> void:
	if !allowed_out:
		return
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("walk_right")
		if dir.x < 0:
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("walk_right")
	elif abs(dir.y) > abs(dir.x):
		if dir.y > 0:
			$AnimatedSprite2D.play("walk_down")
		if dir.y < 0:
			$AnimatedSprite2D.play("walk_up")
	velocity = dir * speed
	var collision_info = move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if "hit" in collider:
			collider.hit()

func make_path() -> void:
	if out_of_house:
		nav_agent.target_position = player.global_position
	else:
		nav_agent.target_position = out_of_house_marker.global_position

func make_scatter_path() -> void:
	if out_of_house:
		nav_agent.target_position = scatter_path[scatter_index].global_position
	else:
		nav_agent.target_position = out_of_house_marker.global_position

func _on_timer_timeout() -> void:
	if Globals.scatter:
		make_scatter_path()
	else:
		make_path()

func _on_navigation_agent_2d_target_reached() -> void:
	if !out_of_house:
		out_of_house = true
	else:
		if scatter_index == scatter_path.size() - 1:
			scatter_index = 0
		else:
			scatter_index += 1

func _on_leave_house_timer_timeout() -> void:
	allowed_out = true
