@tool
extends Node

@onready var input: Label = $"%Input"
@onready var action: Label = $"%Action"

@export var action_input: String:
	set(value):
		action_input = value
		if is_node_ready():
			input.text = value

@export var action_name: String:
	set(value):
		action_name = value
		if is_node_ready():
			action.text = value


func _ready() -> void:
	input.text = action_input
	action.text = action_name
