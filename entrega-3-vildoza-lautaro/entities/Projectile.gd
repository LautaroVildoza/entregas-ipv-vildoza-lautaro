extends Sprite2D

@onready var lifetime_timer = $LifetimeTimer
@onready var screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

@export var VELOCITY: float = 800.0

var direction: Vector2
var _removed: bool = false

func initialize(container, spawn_position: Vector2, direction: Vector2):
	container.add_child(self)
	self.direction = direction
	global_position = spawn_position
	lifetime_timer.timeout.connect(_on_lifetime_timer_timeout)
	screen_notifier.screen_exited.connect(_remove)
	lifetime_timer.start()

func _physics_process(delta):
	position += direction * VELOCITY * delta

func _on_hitbox_body_entered(body: Node2D) -> void:
	var target: Node = body
	if not target.has_method("die") and target.get_parent() and target.get_parent().has_method("die"):
		target = target.get_parent()
	if target.has_method("die"):
		target.die()
	_remove()

func _on_lifetime_timer_timeout():
	_remove()

func _remove():
	if _removed:
		return
	_removed = true
	call_deferred("_do_remove")

func _do_remove():
	if is_instance_valid(self) and get_parent():
		get_parent().remove_child(self)
	queue_free()
