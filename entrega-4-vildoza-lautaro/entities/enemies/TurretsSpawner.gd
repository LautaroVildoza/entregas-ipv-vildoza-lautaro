extends Node

@export var turret_scene: PackedScene
@export var turret_positions: Array[Vector2] = []

func _ready():
	call_deferred("initialize")
	
	
func initialize() -> void:
	for pos in turret_positions:
		var turret_instance: Node2D = turret_scene.instantiate()
		add_child(turret_instance)
		turret_instance.initialize(pos, get_parent())
