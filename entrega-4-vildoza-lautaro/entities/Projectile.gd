extends Sprite2D

@onready var lifetime_timer = $LifetimeTimer
@onready var screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

@export var VELOCITY: float = 800.0

var direction: Vector2

func initialize(container, spawn_position: Vector2, direction: Vector2):
	container.add_child(self)
	self.direction = direction
	global_position = spawn_position
	lifetime_timer.timeout.connect(_on_lifetime_timer_timeout)
	screen_notifier.screen_exited.connect(_remove)
	lifetime_timer.start()

func _physics_process(delta):
	position += direction * VELOCITY * delta

func _on_lifetime_timer_timeout():
	_remove()

func _remove():
	get_parent().remove_child(self)
	queue_free()


func _on_hitbox_area_exited(area: Area2D) -> void:
	pass # Replace with function body.
