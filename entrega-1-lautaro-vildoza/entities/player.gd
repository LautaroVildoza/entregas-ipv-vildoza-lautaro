extends Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		
	if Input.is_action_pressed("move_left"):
		position.x -= 7
	elif Input.is_action_pressed("move_right"):
		position.x += 7
