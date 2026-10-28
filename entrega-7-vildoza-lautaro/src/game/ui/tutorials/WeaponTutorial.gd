extends Node2D

@export var actions: PackedStringArray
@export var actions_textures_paths: Array # (Array, NodePath)
@export var actions_labels_paths: Array # (Array, NodePath)

@export var mouse_buttons_events: Array # (Array, int)
@export var mouse_buttons_textures: Array # (Array, Texture2D)
@export var empty_key_texture: Texture2D

@onready var enabling_animation: AnimationPlayer = $EnablingAnimation

var enabled: bool = false


func _ready() -> void:
	GameState.connect("input_map_changed", Callable(self, "_refresh_inputs"))
	_refresh_inputs()


func _refresh_inputs() -> void:
	for i in actions.size():
		var action: String = actions[i]
		var texture_rect: TextureRect = get_node(actions_textures_paths[i])
		var label: Label = get_node(actions_labels_paths[i])
		
		var event: InputEvent = InputMap.action_get_events(action)[0]
		if event is InputEventMouseButton:
			var id: int = mouse_buttons_events.find(event.button_index)
			if id != -1:
				texture_rect.texture = mouse_buttons_textures[id]
				label.text = ""
		else:
			texture_rect.texture = empty_key_texture
			label.text = event.as_text()


func _on_PlayerCloseArea_body_entered(body: Node) -> void:
	if !enabled:
		enabled = true
		enabling_animation.play("enabled")
