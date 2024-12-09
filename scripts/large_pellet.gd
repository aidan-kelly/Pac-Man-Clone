extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if "score" in body and visible == true:
		visible = false
		body.score(50)
		Globals.invincible = true
