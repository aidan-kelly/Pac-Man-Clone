extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if "score" in body:
		body.score(50)
		queue_free()
