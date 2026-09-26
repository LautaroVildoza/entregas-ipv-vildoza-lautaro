extends Node


func _ready() -> void:
	randomize()


## Agregamos un botoncito primitivo de reset. Por default es la "R".
func _input(event: InputEvent) -> void:
	if event.is_action(&"reset"):
		get_tree().reload_current_scene()


func _on_player_hit(amount: int) -> void:
	pass # Replace with function body.
